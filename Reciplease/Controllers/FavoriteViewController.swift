//
//  FavoriteViewController.swift
//  Reciplease
//
//  Created by Wass on 17/02/2023.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    let identifier = "showFavoritesRecipes"
    var favoriteArray = [Recipe(context: CoreDataStack.shared.viewContext)]


    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == identifier {
            if let nextController = segue.destination as? RecipesTableViewController {
                nextController.favoriteArray = self.favoriteArray
            }
        }
    }
    
    @IBAction func Btn(_ sender: Any) {
        getRecipe()
    }
    
    private func getRecipe() {
        RecipeRepository().getRecipes { Recipes in
            self.favoriteArray = Recipes
            self.performSegue(withIdentifier: self.identifier, sender: nil)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
