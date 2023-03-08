//
//  RecipesTableViewController.swift
//  Reciplease
//
//  Created by Wass on 19/02/2023.
//

import UIKit
import Alamofire

class RecipesTableViewController: UITableViewController {
    
    var recipeArray = [Hits]()
    var imageData = Data()
    var recipeName = String()
    var stringUrlImage = String()
    var ingredientsLines = [String]()
    var ingredients = [Ingredients]()
    var identifier = "showDetailsRecipe"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as? RecipeTableViewCell {
            ingredientsLines = recipeArray[indexPath.row].recipe.ingredientLines
            var ingredientsArray = [String]()
            ingredients = recipeArray[indexPath.row].recipe.ingredients
            for i in 0..<ingredients.count {
                ingredientsArray.append(ingredients[i].food)
            }
            let ingredientsString = ingredientsArray.joined(separator: ", ")
            print(ingredientsString)
            recipeName = recipeArray[indexPath.row].recipe.label

            stringUrlImage = recipeArray[indexPath.row].recipe.image
            AF.request(  stringUrlImage ,method: .get).response{ response in
                switch response.result {
                case .success(let responseData):
                    cell.setUpCell(image: (UIImage(data: responseData!) ?? UIImage(named: "Spaghetti-bolognaise"))!, title: self.recipeName, ingredients: ingredientsString)
                    self.imageData = responseData!
                    
                case .failure(let error):
                    print(error)
                }
            }
            
            return cell
        }
        else {
            let defaultCell = UITableViewCell()
            return defaultCell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170 //Choose your custom row height
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: self.identifier, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == self.identifier {
            if let nextController = segue.destination as? DetailsRecipeViewController {
                var recipe = Recipes(label: self.recipeName, image: self.stringUrlImage , ingredientLines: self.ingredientsLines, ingredients: self.ingredients)
                nextController.recipe = recipe
                nextController.imageData = imageData
            }
        }
    }    
}

