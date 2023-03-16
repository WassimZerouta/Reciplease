//
//  RecipeTableViewCell.swift
//  Reciplease
//
//  Created by Wass on 23/02/2023.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {

    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    
    func setUpCell(image: UIImage, title: String, ingredients: String) {
        backgroundColor = UIColor.black
        recipeImage.image = image
        titleLabel.text = title
        ingredientsLabel.text = ingredients
    }
    
    override func prepareForReuse() {
        recipeImage.image = UIImage(named: "Spaghetti-bolognaise")
        titleLabel.text = ""
        ingredientsLabel.text = ""
        
   
       }
    
    // ADD THE GRADIENT LAYER ON THE RECIPE IMAGE
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


