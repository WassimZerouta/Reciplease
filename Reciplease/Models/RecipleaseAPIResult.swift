//
//  RecipleaseAPIResult.swift
//  Reciplease
//
//  Created by Wass on 19/02/2023.
//

import Foundation
import CoreData

struct RecipleaseAPIResult: Decodable {
    
    var hits: [Hits]
}

struct Hits: Decodable {
    var recipe: Recipes

}

struct Recipes: Decodable {
    var label: String
    var image: String
    var ingredientLines: [String]
    var ingredients: [Ingredients]
}

struct Ingredients: Decodable {
    var food: String
}
