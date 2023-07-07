//
//  FridgeTests.swift
//  RecipleaseTests
//
//  Created by Wass on 07/07/2023.
//

import XCTest
@testable import Reciplease


final class FridgeTests: XCTestCase {
    
    var fridge = Fridge()
    
    
    func testRemoveAllIngredients() {
        fridge.ingredients = ["Cheese", "Chicken"]
        
        fridge.removeAllIngredients()
        
        XCTAssertTrue(fridge.ingredients.isEmpty)
    }
    
    func testAddIngredient() {
        fridge.addIngredient(ingredient: "Cheese")
        
        XCTAssertEqual(fridge.ingredients.count, 1)
        XCTAssertEqual(fridge.ingredients[0], "Cheese")
    }
    
    func testIngredientsString() {
        fridge.ingredients = ["Cheese Chicken", "Bread"]
        
        let ingredientsString = fridge.ingredientsString()
        
        XCTAssertEqual(ingredientsString, "&q=Cheese%20+Chicken%20+Bread")
    }
}
