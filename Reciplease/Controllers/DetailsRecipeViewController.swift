//
//  DetailsRecipeViewController.swift
//  Reciplease
//
//  Created by Wass on 25/02/2023.
//

import UIKit
import CoreData

class DetailsRecipeViewController: UIViewController {
    
    var imageData = Data()
    var recipe = Recipes(label: "", image: "", ingredientLines: [""], ingredients: [])
 
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeLabel: UILabel!
    @IBOutlet weak var favoriteBarButton: UIBarButtonItem!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        recipeImage.image = UIImage(data: imageData) ?? UIImage(named: "Spaghetti-bolognaise")
        recipeLabel.text = recipe.label
    }
    

    @IBAction func favoriteBarButtonPressed(_ sender: Any) {
    
        if favoriteBarButton.tintColor == UIColor.white {
            favoriteBarButton.tintColor = UIColor.systemGreen
            _ = favoriteRecipe(isFavorite: true)
        }
        else {
            favoriteBarButton.tintColor = UIColor.white
            _ = favoriteRecipe(isFavorite: false)
        }
    }
    
    func transformIngredient(ingredients: [Ingredients]) -> [Ingredient] {
        var ingredientArray = [Ingredient]()
        ingredients.forEach { ingredients in
          var ingredient = Ingredient(context: CoreDataStack.shared.viewContext)
            ingredient.food = ingredients.food
            ingredientArray.append(ingredient)
        }
        return ingredientArray
    }
    
    func favoriteRecipe(isFavorite: Bool) -> Bool {
        let recipe =  Recipe(context: CoreDataStack.shared.viewContext)
        recipe.image = self.recipe.image
        recipe.recipeLabel = self.recipe.label
        recipe.ingredients = transformIngredient(ingredients: self.recipe.ingredients)
        recipe.ingredientLines = self.recipe.ingredientLines
        var isFavorite = isFavorite == true ? false : true
        
        do {
            try CoreDataStack.shared.viewContext.save()
        }
        catch {
            print("we were enable to save \(self.recipe.label)")
        }
        
        if isFavorite == false {
            CoreDataStack.shared.viewContext.delete(recipe)
        }
        
        return isFavorite
    }
    
}

extension DetailsRecipeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recipe.ingredientLines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var configuration = cell.defaultContentConfiguration()
        configuration.textProperties.color = .white
        configuration.text = "-  \(recipe.ingredientLines[indexPath.row])"
        cell.contentConfiguration = configuration
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
        
    }
    
    
    
}
