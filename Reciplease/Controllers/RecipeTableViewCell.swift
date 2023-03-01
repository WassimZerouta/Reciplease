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

}
