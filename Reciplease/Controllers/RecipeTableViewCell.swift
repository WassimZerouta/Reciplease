//
//  RecipeTableViewCell.swift
//  Reciplease
//
//  Created by Wass on 23/02/2023.
//

import UIKit
import Alamofire

class RecipeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    
    var ingredientsArray = [String]()
    var ingredient = String()
    
    func fetchImage(stringImage: String) {
        AF.request(  stringImage ,method: .get).response{ response in
            switch response.result {
            case .success(let responseData):
                self.recipeImage.image = UIImage(data: responseData!) ?? UIImage(named: "Spaghetti-bolognaise")
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // Set up the cell
    func setUpCell(image: String, title: String, ingredients: [Ingredients]) {
        
        titleLabel.text = title
        fetchImage(stringImage: image)
        
        for i in 0..<ingredients.count {
            ingredient = ingredients[i].food
            ingredientsArray.append(ingredient)
            ingredientsLabel.text = ingredientsArray.joined(separator: ", ")
        }
    }
    
    // Set up the favorite cell
    func setUpFavoriteCell(image: String, title: String, ingredients: NSSet) {
        titleLabel.text = title
        fetchImage(stringImage: image)
        
        for i in 0..<ingredients.count {
            ingredient = RecipeRepository(coreDataStack: CoreDataStack.shared).transformCoreDataIngredientToIngredient(ingredients: ingredients as! Set<CoreDataIngredients>)[i].food
            ingredientsArray.append(ingredient)
            ingredientsLabel.text = ingredientsArray.joined(separator: ", ")
        }
    }
    
    override func prepareForReuse() {
        recipeImage.image = UIImage(named: "Spaghetti-bolognaise")
        titleLabel.text = ""
        ingredientsLabel.text = ""
    }
    
    // Add the gradient layer on the image
    override func layoutSublayers(of layer: CALayer) {
        
        let width = self.bounds.width
        let height = self.bounds.height
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
}


