//
//  RecipleaseTests.swift
//  RecipleaseTests
//
//  Created by Wass on 30/03/2023.
//

import XCTest
@testable import Reciplease

final class RecipleaseTests: XCTestCase {
    
    func testGetRecipesSucced() {
        //Given
        let apiHelper: APIHelper = MockRecipleaseAPIHelper()
        
        //When
        let expectation = XCTestExpectation(description: "Wait for queu change")
        apiHelper.performRequest(q: "cheese") { success , Recipes in
            //Then
            XCTAssertTrue(success)
            XCTAssertNotNil(Recipes)
            XCTAssertEqual(Recipes?.count, 2)
            expectation.fulfill()
            
            
        }
        wait(for: [expectation], timeout: 0.01)
        
    }
}
