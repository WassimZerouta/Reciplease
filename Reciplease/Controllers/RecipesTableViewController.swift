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
    var favoriteArray = [Recipe(context: CoreDataStack.shared.viewContext)]
    var ingredientArray = Set<CoreDataIngredients>()
    var imageData = Data()
    var recipeName = String()
    var stringUrlImage = String()
    var ingredientsLines = [String]()
    var ingredients = [Ingredients]()
    var identifier = "showDetailsRecipe"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(recipeArray)
    }
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as? RecipeTableViewCell {
            if recipeArray.isEmpty {ingredientsLines = favoriteArray[indexPath.row].ingredientLines ?? [""] } else {ingredientsLines = recipeArray[indexPath.row].recipe.ingredientLines }
            
            var ingredientsArray = [String]()
            if recipeArray.isEmpty {
                for i in 0..<favoriteArray[indexPath.row].coreDataIngredients!.count {
                    ingredientsArray.append(   RecipeRepository().transformCoreDataIngredientToIngredient(ingredients: favoriteArray[indexPath.row].coreDataIngredients as! Set<CoreDataIngredients>)[i].food)
                }
                
            }
            
            else {
            ingredients = recipeArray[indexPath.row].recipe.ingredients
            
            for i in 0..<ingredients.count {
                ingredientsArray.append(ingredients[i].food)
            }
        }
            cell.ingredientsLabel.text = ingredientsArray.joined(separator: ", ")
            if recipeArray.isEmpty {recipeName = favoriteArray[indexPath.row].recipeLabel ?? "" } else { cell.titleLabel.text = recipeArray[indexPath.row].recipe.label}
            recipeName = cell.titleLabel.text!
            if recipeArray.isEmpty {stringUrlImage = favoriteArray[indexPath.row].image ?? "" } else { stringUrlImage = recipeArray[indexPath.row].recipe.image}
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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let nextController = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailsRecipeViewController {
            let recipe = Recipes(label: recipeArray[indexPath.row].recipe.label, image: recipeArray[indexPath.row].recipe.image , ingredientLines: recipeArray[indexPath.row].recipe.ingredientLines, ingredients: recipeArray[indexPath.row].recipe.ingredients)
            nextController.label = recipeArray[indexPath.row].recipe.label
            nextController.recipe = recipe
            nextController.imageData = imageData
            self.navigationController?.pushViewController(nextController, animated: true)
        }
    }
    
 
}

