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
    
    func testGetDessertDetail() async throws {
        let mockMealDetails = [
            MealDetail(
                meal: "Apam balik",
                instructions: "Mix milk, oil and egg together. Sift flour, baking powder and salt into the mixture. Stir well until all ingredients are combined evenly.",
                mealThumb: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg",
                ingredients: ["strIngredient1": "Milk"]
            )
        ]
        
        let mockMealData = MealDetailData(meals: mockMealDetails)
        let mockData = try JSONEncoder().encode(mockMealData)
        
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, mockData)
        }
        
        let mockSession = URLSession(configuration: URLSessionConfiguration.ephemeral)
        let apiCaller = APICaller(session: mockSession)
        let mealDetails = try await apiCaller.getDessertDetail(id: "53049")
        
        XCTAssertEqual(mealDetails.count, 1)
        let mealDetail = mealDetails.first
        XCTAssertEqual(mealDetail?.meal, "Apam balik")
        XCTAssertEqual(mealDetail?.instructions, "Mix milk, oil and egg together. Sift flour, baking powder and salt into the mixture. Stir well until all ingredients are combined evenly.\r\n\r\nSpread some batter onto the pan. Spread a thin layer of batter to the side of the pan. Cover the pan for 30-60 seconds until small air bubbles appear.\r\n\r\nAdd butter, cream corn, crushed peanuts and sugar onto the pancake. Fold the pancake into half once the bottom surface is browned.\r\n\r\nCut into wedges and best eaten when it is warm.")
        XCTAssertEqual(mealDetail?.mealThumb, "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg")
        XCTAssertEqual(mealDetail?.ingredients["Milk"], "200ml")
    }
}
