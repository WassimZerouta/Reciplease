//
//  CoreDataRecipe.swift
//  Reciplease
//
//  Created by Wass on 10/03/2023.
//

import Foundation

import Foundation
import CoreData


extension Recipe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recipe> {
        return NSFetchRequest<Recipe>(entityName: "Recipe")
    }

    @NSManaged public var image: String?
    @NSManaged public var ingredientLines: [String]?
    @NSManaged public var recipeLabel: String?
    @NSManaged public var coreDataIngredients: NSSet?

}

// MARK: Generated accessors for coreDataIngredients
extension Recipe {



}

extension Recipe : Identifiable {

}
