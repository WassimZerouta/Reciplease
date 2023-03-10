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
 
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeLabel: UILabel!
    @IBOutlet weak var favoriteBarButton: UIBarButtonItem!
    
    @IBOutlet weak var tableView: UITableView!
    
    var label = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getImage()
        recipeLabel.text = recipe.label
      
    }
    

    @IBAction func favoriteBarButtonPressed(_ sender: Any) {
    saveRecipe()
    }
    
    
    func saveRecipe() {
        
            let image = self.recipe.image
            let recipeLabel = self.recipe.label
            let ingredients =  self.recipe.ingredients
            let ingredientLines = self.recipe.ingredientLines
        
        RecipeRepository().saveRecipe(image: image, recipeLabel: recipeLabel, ingredients: ingredients, ingredientLines: ingredientLines)
    }
    
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
        configuration.text = "-  \(recipe.ingredientLines[indexPath.row])"
        cell.contentConfiguration = configuration
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
        
    }
    
    
    
}
