//
//  Fridge.swift
//  Reciplease
//
//  Created by Wass on 06/07/2023.
//

import Foundation

struct Fridge {
    
    var ingredients: [String] = []
    
    mutating func removeAllIngredients() {
        ingredients.removeAll()
    }
    
    mutating func addIngredient(ingredient: String) {
        ingredients.append(ingredient)

    }
    
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
