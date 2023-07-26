//
//  CoreDataTest.swift
//  RecipleaseTests
//
//  Created by Wass on 26/07/2023.
//

import XCTest
import CoreData
@testable import Reciplease

final class CoreDataTest: XCTestCase {

    let coreDataStack = TestCoreDataStack.shared
    let repository = RecipeRepository(coreDataStack: TestCoreDataStack.shared)
    
    override func tearDown() {

        let context = coreDataStack.viewContext

        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Recipe.fetchRequest()
        
        let removeAll = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(removeAll)
            
            try context.save()
        } catch {
            print("Erreur lors de la suppression des données de Core Data: \(error)")
        }
        super.tearDown()
    }
    
    
    func testSaveRecipe() {
        
        let recipe = Recipes(label: "Riz", image: "image", ingredientLines: ["", "", "", ""], ingredients: [])
        
        repository.saveRecipe(recipes: recipe)
        
        repository.getRecipes { recipes in
            XCTAssertEqual(recipes.count, 1)
        }
        

    }
    
    func testDeleteRecipe() {
        let recipe1 = Recipes(label: "Riz", image: "image", ingredientLines: ["", "", "", ""], ingredients: [])
        repository.saveRecipe(recipes: recipe1)
        
        let recipe2 = Recipes(label: "Pates", image: "image", ingredientLines: ["", "", "", ""], ingredients: [])
        repository.saveRecipe(recipes: recipe2)


        repository.deleteRecipes(recipeLabel: "Riz")
        
        repository.getRecipes { recipes in
            print(recipes)
            XCTAssertEqual(recipes.count, 1)
        }
        
    }
    
    func testGetRecipes() {
        let recipe1 = Recipes(label: "Riz", image: "image", ingredientLines: ["", "", "", ""], ingredients: [])
        repository.saveRecipe(recipes: recipe1)
        
        let recipe2 = Recipes(label: "Pates", image: "image", ingredientLines: ["", "", "", ""], ingredients: [])
        repository.saveRecipe(recipes: recipe2)
        
        repository.getRecipes { recipes in
            XCTAssertEqual(recipes.count, 2)
        }
        
    }
}


