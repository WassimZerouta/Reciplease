//
//  RecipesTableViewController.swift
//  Reciplease
//
//  Created by Wass on 19/02/2023.
//

import UIKit
import Alamofire

class RecipesTableViewController: UITableViewController {
    
    
    @IBOutlet weak var recipeBanner: UIImageView!
    
    var recipeArray = [Hits]()
    var favoriteArray: [Recipe] = []
    
    var imageData = Data()
    var recipeName = String()
    var stringUrlImage = String()
    var ingredientsLines = [String]()
    var ingredients = [Ingredients]()
    var favoritesIngredients = NSSet()
    
    
    var ingredient = String()
    var identifier = "showDetailsRecipe"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.favoriteArray = RecipeRepository().getFavoriteArray()
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
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as? RecipeTableViewCell {
            
            // Display recipe from data recipeArray or favoriteArray
            ingredientsLines = recipeArray.isEmpty ?  favoriteArray[indexPath.row].ingredientLines ?? [""]  : recipeArray[indexPath.row].recipe.ingredientLines
            
            if recipeArray.isEmpty {
                var ingredientsArray = [String]()
                
                favoritesIngredients = favoriteArray[indexPath.row].coreDataIngredients!
                
                for i in 0..<favoritesIngredients.count {
                    ingredient = RecipeRepository().transformCoreDataIngredientToIngredient(ingredients: favoritesIngredients as! Set<CoreDataIngredients>)[i].food
                    ingredientsArray.append(ingredient)
                    cell.ingredientsLabel.text = ingredientsArray.joined(separator: ", ")
                }
            }
            else {
                var ingredientsArray = [String]()
                
                ingredients = recipeArray[indexPath.row].recipe.ingredients
                
                for i in 0..<ingredients.count {
                    ingredient = ingredients[i].food
                    ingredientsArray.append(ingredient)
                    cell.ingredientsLabel.text = ingredientsArray.joined(separator: ", ")
                }
            }
            
            cell.titleLabel.text = recipeArray.isEmpty ? favoriteArray[indexPath.row].recipeLabel ?? "" : recipeArray[indexPath.row].recipe.label
            
            recipeName = cell.titleLabel.text!
            
            stringUrlImage = recipeArray.isEmpty ? favoriteArray[indexPath.row].image ?? ""  : recipeArray[indexPath.row].recipe.image
            
            AF.request(  stringUrlImage ,method: .get).response{ response in
                switch response.result {
                case .success(let responseData):
                    cell.recipeImage.image = UIImage(data: responseData!) ?? UIImage(named: "Spaghetti-bolognaise")
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
    
    // Height for row
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    // When cell is selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let nextController = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailsRecipeViewController {
            let recipe: Recipes
            if recipeArray.isEmpty {
                // Send Recipes Object from favoriteArray to the nextController
                recipe = Recipes(label: favoriteArray[indexPath.row].recipeLabel ?? "", image: favoriteArray[indexPath.row].image! , ingredientLines: favoriteArray[indexPath.row].ingredientLines ?? [], ingredients: RecipeRepository().transformCoreDataIngredientToIngredient(ingredients: favoriteArray[indexPath.row].coreDataIngredients as! Set<CoreDataIngredients>) )
                nextController.recipe = recipe
                nextController.favoriteBarButton.tintColor = UIColor.systemGreen
            }
            else {
                // Send Recipes Object from recipeArray to the nextController
                recipe = Recipes(label: recipeArray[indexPath.row].recipe.label, image: recipeArray[indexPath.row].recipe.image , ingredientLines: recipeArray[indexPath.row].recipe.ingredientLines, ingredients: recipeArray[indexPath.row].recipe.ingredients)
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

