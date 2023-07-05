//
//  ViewController.swift
//  Reciplease
//
//  Created by Wass on 17/02/2023.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searcBarLabel: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var yourIngredientsLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    
    
    
    var ingredientsArray = [String]()
    var recipeArray = [Hits]()
    let identifier = "showRecipes"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        accessibility()
    }
    
   // Accessibily function
   private func accessibility() {
        searcBarLabel.isAccessibilityElement = true
        searcBarLabel.accessibilityLabel = "Here, Write the ingredients present in your fridge"
        addButton.isAccessibilityElement = true
        addButton.accessibilityLabel = "Click to add your ingredients"
        clearButton.isAccessibilityElement = true
        clearButton.accessibilityLabel = "Click to Delete all your ingredients"
        searchButton.isAccessibilityElement = true
        searchButton.accessibilityLabel = "Click to find all the recipes available with your ingredients"
        tableView.isAccessibilityElement = true
        tableView.accessibilityLabel = "Here, there is the list of your ingredients"
    }
    
    
    //Add ingredient(s) in ingredientsArray
    @IBAction func addButtonPressed(_ sender: Any) {
        if let ingredient = searcBarLabel.text {
            ingredientsArray.append(ingredient)
            print(stringArray(array: ingredientsArray))
        }
        tableView.reloadData()
    }
    
    
    // Clear ingredients
    @IBAction func clearButtonPressed(_ sender: Any) {
        ingredientsArray.removeAll()
        tableView.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == identifier  {
            if let nextController = segue.destination as? RecipesTableViewController {
                nextController.recipeArray = self.recipeArray
            }
        }
    }
    
    // Search recipes matching to the ingredients
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        
        RecipleaseAPIHelper.shared.performRequest(q: stringArray(array: ingredientsArray)) { _ , Recipes in
            DispatchQueue.main.async {
                self.recipeArray = Recipes!
                if Recipes?.isEmpty == false {
                    self.performSegue(withIdentifier: self.identifier, sender: nil)}
                else {
                    self.noRecipeFound()
                }
                
            }
            
        }
    }
        
    // Alert if No recipe was found
    func noRecipeFound() {
        let alertController = UIAlertController(title: "No recipes found", message: "We couldn't find any recipes matching your search.", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
        
        
    // Stringify the array of ingredients
        func stringArray(array: [String]) -> String {
            
            var ingredient = array.joined(separator: "%20+")
            ingredient.removeAll { Character in
                Character == ","
            }
            let array = ingredient.components(separatedBy: " ")
            ingredient = array.joined(separator: "%20+")
            let ingredients = "&q=\(ingredient)"
            return ingredients
        }
    }
    
    
    extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
        
        // Number of rows
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return ingredientsArray.count
        }
        
        // Cell configuration
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = UITableViewCell()
            var configuration = cell.defaultContentConfiguration()
            configuration.textProperties.color = .white
            configuration.textProperties.font = UIFont(name: "Chalkduster", size: 18)!
            configuration.text = "-  \(ingredientsArray[indexPath.row])"
            cell.contentConfiguration = configuration
            
            return cell
        }
        
        // Define backgroundColor of the cell
        func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            cell.backgroundColor = UIColor.clear
        }
        
        
    }

