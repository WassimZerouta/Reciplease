//
//  RecipeRepository.swift
//  Reciplease
//
//  Created by Wass on 08/03/2023.
//

import Foundation
import CoreData

final class RecipeRepository {
    
    let coreDataStack: CoreDataStack

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
           print("error")
         completion([])
       }
    }
    
    func getIngredient() -> String {
       let request: NSFetchRequest<CoreDataIngredients> = CoreDataIngredients.fetchRequest()
        request.returnsObjectsAsFaults = false
       do {
         let coreDataIngredients = try coreDataStack.viewContext.fetch(request)
           return coreDataIngredients[0].food!
       } catch {
           print("error")
         return ""
       }
    }
    


    func saveRecipe(image: String, recipeLabel: String, ingredients: [Ingredients], ingredientLines: [String], isFavorite: Bool) {
       let recipe = Recipe(context: coreDataStack.viewContext)
        recipe.image = image
        recipe.recipeLabel = recipeLabel
        recipe.isFavorite = isFavorite
        recipe.coreDataIngredients = transformIngredient(ingredients: ingredients) as NSSet
        recipe.ingredientLines = ingredientLines

       do {
         try coreDataStack.viewContext.save()
           print(recipe)
       } catch {
         print("We were unable to save \(recipeLabel)")
       }
    }
    
    func deleteRecipes(recipe: Recipe) {
         coreDataStack.viewContext.delete(recipe)
        do {
          try coreDataStack.viewContext.save()
            print("OKOK")
        } catch {
          print("ERROR: \(error)")
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
