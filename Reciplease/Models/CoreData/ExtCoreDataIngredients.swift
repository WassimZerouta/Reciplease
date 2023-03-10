//
//  Ing.swift
//  Reciplease
//
//  Created by Wass on 10/03/2023.
//

import Foundation
import CoreData


extension CoreDataIngredients {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataIngredients> {
        return NSFetchRequest<CoreDataIngredients>(entityName: "CoreDataIngredients")
    }

    @NSManaged public var food: String?
    @NSManaged public var recipe: Recipe?

}

// MARK: Generated accessors for coreDataIngredients
extension CoreDataIngredients {



}

extension CoreDataIngredients : Identifiable {

}
