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
    var favoriteArray: [Recipe] = []
    
    var label: String = ""
    var image: String = ""
    var ingredientsLines: [String] = [""]
    
    let cellIdentifier = "recipeCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.favoriteArray = RecipeRepository(coreDataStack: CoreDataStack.shared).getFavoriteArray()
        self.tableView.reloadData()
        noFavoriteRecipeAlert()
    }
    
    // Alert if no favorite recipe
    private func noFavoriteRecipeAlert() {
        if recipeArray.isEmpty && favoriteArray.isEmpty {
            let alertController = UIAlertController(title: "Favorites", message: "You have not added any recipes to your favourites!", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(action)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    
    // Number of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recipeArray.isEmpty ?  favoriteArray.count : recipeArray.count
    }
    
    // Configure cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? RecipeTableViewCell {
            
            guard recipeArray.isEmpty else {
                
                image = recipeArray[indexPath.row].recipe.image
                label = recipeArray[indexPath.row].recipe.label
                let ingredients = recipeArray[indexPath.row].recipe.ingredients
                
                cell.setUpCell(image: image , title: label, ingredients: ingredients)
                
                return cell
            }
            
            image = favoriteArray[indexPath.row].image ?? ""
            label = favoriteArray[indexPath.row].recipeLabel ?? ""
            let favoritesIngredients = favoriteArray[indexPath.row].coreDataIngredients!
            
            cell.setUpFavoriteCell(image: image, title: label, ingredients: favoritesIngredients)
            
            return cell
        }
        else {
            let defaultCell = UITableViewCell()
            return defaultCell
        }
    }
    
    // Height for row
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    // When cell is selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let nextController = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailsRecipeViewController {
            let recipe: Recipes
            let ingredients: [Ingredients]
            
            
            if recipeArray.isEmpty {
                // Send Recipes Object from favoriteArray to the nextController
                label = favoriteArray[indexPath.row].recipeLabel ?? ""
                image = favoriteArray[indexPath.row].image!
                ingredientsLines = favoriteArray[indexPath.row].ingredientLines ?? []
                ingredients = RecipeRepository(coreDataStack: CoreDataStack.shared).transformCoreDataIngredientToIngredient(ingredients: favoriteArray[indexPath.row].coreDataIngredients as! Set<CoreDataIngredients>)
                
                recipe = Recipes(label: label, image: image , ingredientLines: ingredientsLines , ingredients: ingredients )
                
                nextController.recipe = recipe
                nextController.favoriteBarButton.tintColor = UIColor.systemGreen
            }
            else {
                // Send Recipes Object from recipeArray to the nextController
                label = recipeArray[indexPath.row].recipe.label
                image = recipeArray[indexPath.row].recipe.image
                ingredientsLines = recipeArray[indexPath.row].recipe.ingredientLines
                ingredients = recipeArray[indexPath.row].recipe.ingredients
                
                recipe = Recipes(label: label, image: image , ingredientLines: ingredientsLines , ingredients: ingredients)
                
                nextController.recipe = recipe
                
                for i in 0..<favoriteArray.count {
                    // If its favoritesRecipe,  send the recipeObject, to delete it if neccessary and color the star in green
                    if favoriteArray[i].isFavorite && (favoriteArray[i].recipeLabel == recipeArray[indexPath.row].recipe.label) {
                        nextController.favoriteBarButton.tintColor = UIColor.systemGreen
                    }
                }
            }
            self.navigationController?.pushViewController(nextController, animated: true)
        }
    }
}

