//
//  Fridge.swift
//  Reciplease
//
//  Created by Wass on 06/07/2023.
//

import Foundation

struct Fridge {
    
    var ingredients: [String] = []
    
    // Remove all the ingredients
    mutating func removeAllIngredients() {
        ingredients.removeAll()
    }
    
    // Add ingredients
    mutating func addIngredient(ingredient: String) {
        ingredients.append(ingredient)

    }
    
    
    // Returns a string from an array of ingredients
    func ingredientsString() -> String {
        
        var ingredient = ingredients.joined(separator: "%20+")
        ingredient.removeAll { Character in
            Character == ","
        }
        let array = ingredient.components(separatedBy: " ")
        ingredient = array.joined(separator: "%20+")
        let ingredients = "&q=\(ingredient)"
        return ingredients
    }
}
