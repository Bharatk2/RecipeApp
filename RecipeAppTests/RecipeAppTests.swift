//
//  RecipeAppTests.swift
//  RecipeAppTests
//
//  Created by Admin on 7/2/24.
//

import XCTest
@testable import RecipeApp

final class RecipeAppTests: XCTestCase {
    let timeout: TimeInterval = 5
    
    override func setUpWithError() throws {
        MockURLProtocol.requestHandler = nil
        // using ephemeral configuration to implement testing in order to avoid storing data to disk.
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
    }

    override func tearDownWithError() throws {
        MockURLProtocol.requestHandler = nil
    }

    /* 
     This test verifies that the getAllDessertCategory method of the APICaller class
      correctly fetches and decodes a list of dessert categories from a remote API.
     */
    func testGetAllDessertCategory() async throws {
        let mockMeals = [
            MealData(mealID: "53049", meal: "Apam balik", mealThumb: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg")
        ]
        
        let mockMealModel = Meal(meals: mockMeals)
        let mockData = try JSONEncoder().encode(mockMealModel)
        
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, mockData)
        }
        
        let mockSession = URLSession(configuration: URLSessionConfiguration.ephemeral)
        let apiCaller = APICaller(session: mockSession)
        let meals = try await apiCaller.getAllDessertCategory()
        
        XCTAssertEqual(meals.first?.mealID, "53049")
        XCTAssertEqual(meals.first?.meal, "Apam balik")
        XCTAssertEqual(meals.first?.mealThumb, "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg")
    }
}
