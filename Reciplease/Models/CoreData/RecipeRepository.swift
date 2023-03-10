//
//  RecipeRepository.swift
//  Reciplease
//
//  Created by Wass on 08/03/2023.
//

import Foundation
import CoreData

final class RecipeRepository {
    
    private let coreDataStack: CoreDataStack

    init(coreDataStack: CoreDataStack = CoreDataStack.shared) {
      self.coreDataStack = coreDataStack
    }
    
    func getRecipes(completion: ([Recipe]) -> Void) {
       let request: NSFetchRequest<Recipe> = Recipe.fetchRequest()
        request.returnsObjectsAsFaults = false
       do {
         let recipes = try coreDataStack.viewContext.fetch(request)
         completion(recipes)
       } catch {
           print(request)
         completion([])
       }
    }


    func saveRecipe(image: String, recipeLabel: String, ingredients: [Ingredients], ingredientLines: [String]) {
       let recipe = Recipe(context: coreDataStack.viewContext)
        recipe.image = image
        recipe.recipeLabel = recipeLabel
        var coreDataIngredients = recipe.coreDataIngredients as! Set<CoreDataIngredients>
        coreDataIngredients = transformIngredient(ingredients: ingredients)
        recipe.ingredientLines = ingredientLines

       do {
         try coreDataStack.viewContext.save()
           print(recipe)
       } catch {
         print("We were unable to save \(recipeLabel)")
       }
    }
    
    private  func transformIngredient(ingredients: [Ingredients]) -> Set<CoreDataIngredients> {
        var ingredientArray = Set<CoreDataIngredients>()
        ingredients.forEach { ingredients in
            let ingredient = CoreDataIngredients(context: coreDataStack.viewContext)
            ingredient.food = ingredients.food
            do {
              try coreDataStack.viewContext.save()
                print(ingredient)
            } catch {
                print("We were unable to save \(ingredient.food ?? "the ingredient")")
            }

            ingredientArray.insert(ingredient)
              }
        
        return ingredientArray
    }
    
    func transformCoreDataIngredientToIngredient(ingredients: Set<CoreDataIngredients>) -> [Ingredients]{
        var ingredientArray = [Ingredients]()
        ingredients.forEach { ingredients in
            var ingredient = Ingredients(food: "")
            ingredient.food = ingredients.food!
            ingredientArray.append(ingredient)
              }
        
        return ingredientArray
    }
    
}
