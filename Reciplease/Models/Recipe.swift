//
//  Recipe.swift
//  Reciplease
//
//  Created by Wass on 19/02/2023.
//

import Foundation

class Recipe {
    
    var label: String
    var image: String
    var ingredients: [String]
    
    init(label: String, image: String, ingredients: [String]) {
        self.label = label
        self.image = image
        self.ingredients = ingredients
    }
}
