//
//  RecipesAppTests.swift
//  RecipesAppTests
//
//  Created by Gagan Pareek on 19/05/23.
//

import XCTest
@testable import RecipesApp

final class RecipesAppTests: XCTestCase {
    private var sut0: MealManager!
    private var sut1: ViewModel!
    
    override func setUpWithError() throws {
        sut0 = MealManager()
        sut1 = ViewModel()
    }
    
    override func tearDownWithError() throws {
        sut0 = nil
        sut1 = nil
    }
    
    // Test for [Meal] data
    func testGetMeal() {
        let meals = sut0.getMeal()
        
        XCTAssertNotNil(meals)
        XCTAssertTrue(meals.count > 0)
    }
    
    // Test for [DetailMeal] data
    func testGetDetailedMeal() {
        let mockMealId = 52768
        sut0.getDetailedMeal(idMeal: mockMealId) {
            detailMeal in
            XCTAssertNotNil(detailMeal.strMeal)
        }
    }
    
    func testGetMealIndexWithValidId() {
        
        let index = sut1.getMealIndex(meal: Meal(strMeal: "", strMealThumb: "", idMeal: "1234"))
        
        // Perform assertions on the returned index
        XCTAssertEqual(index, 1234)
    }
    
    func testGetMealIndexWithInvalidId() {
        let index = sut1.getMealIndex(meal: Meal(strMeal: "", strMealThumb: "", idMeal: "abcd"))
        
        // Perform assertions on the returned index
        XCTAssertEqual(index, 0)
    }
    
    func testFormatString() {
           // Test case 1: Empty string
           let emptyString = ""
        XCTAssertEqual(sut1.formatString(detail: emptyString), "", "Unexpected formatted string")

           // Test case 2: Non-empty string
           let nonEmptyString = "Hello, world!"
        XCTAssertEqual(sut1.formatString(detail: nonEmptyString), "Hello, world!", "Unexpected formatted string")
       }
}
