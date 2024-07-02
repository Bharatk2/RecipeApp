//
//  ApiManager.swift
//  RecipeApp
//
//  Created by Admin on 7/2/24.
//
import Foundation
import Combine

struct Constants {
    static let dessertListURL = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
    static let dessertByIDURL = "https://themealdb.com/api/json/v1/1/lookup.php?i="
}

class APICaller {
    static let shared = APICaller()
    
    private let session: URLSession
    
    // Use dependency injection to allow different URLSession configurations
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    // MARK: API Caller AllDessertCategory
    /**
     Fetches all dessert categories from the API.
     
     - Throws: `APIError.failedToGetData` if the URL is invalid.
     - `APIError.decodingError` if there is an error during JSON decoding.
     - Returns: An array of `Meal` objects filtered to remove any null or empty values.
     */
    public func getAllDessertCategory() async throws -> [MealData] {
        let dessertCategoryURL = "\(Constants.dessertListURL)"
        guard let url = URL(string: dessertCategoryURL) else {
            throw APIError.failedToGetData
        }
        
        let (data, _) = try await session.data(from: url)
        
        do {
            let result = try JSONDecoder().decode(Meal.self, from: data)
            return result.meals.filter { !$0.mealID.isEmpty && !$0.meal.isEmpty && !$0.mealThumb.isEmpty }
        } catch {
            throw APIError.decodingError
        }
    }
    
    // MARK: API Caller DessertDetail
    /**
     Fetches detailed information for a specific dessert by its ID from the API.
     
     - Parameter id: The ID of the dessert to fetch details for.
     - Throws: `APIError.failedToGetData` if the URL is invalid.
     ` APIError.decodingError` if there is an error during JSON decoding.
     - Returns: An array of `MealDetail` objects filtered to remove any null or empty values.
     */
    public func getDessertDetail(id: String) async throws -> [MealDetail] {
        let dessertDetailURL = "\(Constants.dessertByIDURL)\(id)"
        guard let url = URL(string: dessertDetailURL) else {
            throw APIError.failedToGetData
        }
        
        let (data, _) = try await session.data(from: url)
        do {
            let result = try JSONDecoder().decode(MealDetailData.self, from: data)
            return result.meals.filter { !$0.meal.isEmpty && !$0.instructions.isEmpty && !$0.mealThumb.isEmpty && !$0.ingredients.isEmpty }
        } catch {
            throw APIError.decodingError
        }
    }
}
