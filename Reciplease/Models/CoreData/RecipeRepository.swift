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
        print(recipes)
         completion(recipes)
       } catch {
           print("error")
         completion([])
       }
    }
    

    func saveRecipe(recipes: Recipes) {
       let recipe = Recipe(context: coreDataStack.viewContext)
        recipe.image = recipes.image
        recipe.recipeLabel = recipes.label
        recipe.isFavorite = true
        recipe.coreDataIngredients = transformIngredient(ingredients: recipes.ingredients) as NSSet
        recipe.ingredientLines = recipes.ingredientLines

       do {
         try coreDataStack.viewContext.save()
       } catch {
           print("We were unable to save \(recipes.label)")
       }
    }
    
    
    func deleteRecipes(recipeLabel: String) {
        let fetchRequest: NSFetchRequest<Recipe> = Recipe.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "recipeLabel == %@", recipeLabel)

        do {
            let recipes = try coreDataStack.viewContext.fetch(fetchRequest)
            for recipe in recipes {
                coreDataStack.viewContext.delete(recipe)
            }
            try coreDataStack.viewContext.save()
        } catch {
            print("We were unable to delete \(error)")
        }
    }
    
     func getFavoriteArray() -> [Recipe] {
        var favoriteArray: [Recipe] = []
        RecipeRepository().getRecipes { recipes in
            favoriteArray = recipes
            favoriteArray.removeAll { recipe in
                recipe.recipeLabel == nil
            }
             favoriteArray.reverse()
        }
        return favoriteArray
    }
    
    
    private  func transformIngredient(ingredients: [Ingredients]) -> Set<CoreDataIngredients> {
        var ingredientArray = Set<CoreDataIngredients>()
        ingredients.forEach { ingredients in
            let ingredient = CoreDataIngredients(context: coreDataStack.viewContext)
            ingredient.food = ingredients.food
            do {
              try coreDataStack.viewContext.save()
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
