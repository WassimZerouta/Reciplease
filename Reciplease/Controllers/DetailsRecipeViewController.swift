//
//  DetailsRecipeViewController.swift
//  Reciplease
//
//  Created by Wass on 25/02/2023.
//

import UIKit
import CoreData
import Alamofire

class DetailsRecipeViewController: UIViewController {
    
    var imageData = Data()
    var recipe = Recipes(label: "", image: "", ingredientLines: [""], ingredients: [])
    // Cause issue
    var favoriteRecipe = Recipe(context: CoreDataStack.shared.viewContext)
    

    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeLabel: UILabel!
    @IBOutlet weak var favoriteBarButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getImage()
        recipeLabel.text = recipe.label
        layoutSublayers()
        accessibility()
        if favoriteRecipe.recipeLabel == nil {
            // TO DO : Implement deleteRecipe(), then call it here
            RecipeRepository().deleteRecipes(recipe: favoriteRecipe)
        }
    }
    
    private func accessibility() {
        favoriteBarButton.isAccessibilityElement = true
        favoriteBarButton.accessibilityLabel = "Click to add or remove favorite"
        
    }
    func layoutSublayers() {
        
        let width = recipeImage.bounds.width
        let height = recipeImage.bounds.height
        let sHeight:CGFloat = 60.0
        
        if recipeImage.layer.sublayers?.first is CAGradientLayer {
            }
        else {
            let gradient = CAGradientLayer()
            gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
            gradient.frame = CGRect(x: 0, y: height - sHeight, width: width, height: sHeight)
            recipeImage.layer.insertSublayer(gradient, at: 0)
        }
    }
    

    @IBAction func favoriteBarButtonPressed(_ sender: Any) {
        if favoriteRecipe.isFavorite == true {
            print("OK \(favoriteRecipe.isFavorite)")
            favoriteBarButton.tintColor = UIColor.white
            // TO DO : Implement deleteRecipe(), then call it here
            favoriteRecipe.isFavorite = false
            RecipeRepository().deleteRecipes(recipe: favoriteRecipe)
            
        
        }
        else if favoriteRecipe.isFavorite == false {
            print("KO \(favoriteRecipe.isFavorite)")
            favoriteBarButton.tintColor = UIColor.systemGreen
            saveRecipe()
        }
    
    
    }
    
    // Save Favorite Recipe
    func saveRecipe() {
        favoriteBarButton.tintColor = UIColor.systemGreen
            let image = self.recipe.image
            let recipeLabel = self.recipe.label
            let ingredients =  self.recipe.ingredients
            let ingredientLines = self.recipe.ingredientLines
            
        
       favoriteRecipe = RecipeRepository().saveRecipe(image: image, recipeLabel: recipeLabel, ingredients: ingredients, ingredientLines: ingredientLines, isFavorite: true)
    }
    
    // Get recipeImage to display
    func getImage() {
        AF.request(  recipe.image ,method: .get).response{ response in
            switch response.result {
            case .success(let responseData):
                
                self.recipeImage.image = UIImage(data: responseData!) ?? UIImage(named: "Spaghetti-bolognaise")
                
                
            case .failure(let error):
                print(error)
            }
        }
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
        configuration.textProperties.font = UIFont(name: "Chalkduster", size: 15)!
        configuration.text = "-  \(recipe.ingredientLines[indexPath.row])"
        cell.contentConfiguration = configuration
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
        
    }
}
