//
//  RecipleaseAPIResult.swift
//  Reciplease
//
//  Created by Wass on 19/02/2023.
//

import Foundation

struct RecipleaseAPIResult: Decodable {
    
    var hits: [Hits]
}

struct Hits: Decodable {
    var recipe: Recipes

}

struct Recipes: Decodable {
    var label: String
    var image: String
    var images: Images
    var ingredientLines: [String]
    var ingredients: [Ingredients]
}

struct Images: Decodable {
    var REGULAR: Regular
}

struct Regular: Decodable {
    var url: String
}

struct Ingredients: Decodable {
    var food: String
}
