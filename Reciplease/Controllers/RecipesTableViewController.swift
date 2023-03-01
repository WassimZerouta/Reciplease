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
    var identifier = "showDetailsRecipe"

    override func viewDidLoad() {
        super.viewDidLoad()
      
        print(recipeArray)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return recipeArray.count
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        if let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as? RecipeTableViewCell {
            var ingredientsArray = [String]()
            var ingredients = recipeArray[indexPath.row].recipe.ingredients
            for i in 0..<ingredients.count {
                ingredientsArray.append(ingredients[i].food)
            }
            let ingredientsString = ingredientsArray.joined(separator: ", ")
            print(ingredientsString)
            let recipeName = recipeArray[indexPath.row].recipe.label
    
            let stringUrlImage = recipeArray[indexPath.row].recipe.images.REGULAR.url
            AF.request(  stringUrlImage ,method: .get).response{ response in
             switch response.result {
              case .success(let responseData):
                 cell.setUpCell(image: (UIImage(data: responseData!) ?? UIImage(named: "Spaghetti-bolognaise"))!, title: recipeName, ingredients: ingredientsString)

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


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
