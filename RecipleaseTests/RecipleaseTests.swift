//
//  RecipleaseTests.swift
//  RecipleaseTests
//
//  Created by Wass on 30/03/2023.
//

import XCTest
@testable import Reciplease

final class RecipleaseTests: XCTestCase {

    func testShouldReturnResponse() {
        //Given
        let expectation = XCTestExpectation(description: "Wait for queu change")
        //When
        RecipleaseAPIHelper.shared.performRequest(q: "&q=chicken") { success, Recipes in
            XCTAssertTrue(success)
            XCTAssertNotNil(Recipes)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
}

}
