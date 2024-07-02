//
//  Meal.swift
//  RecipeApp
//
//  Created by Admin on 7/2/24.
//

import Foundation

struct Meal: Codable {
    let meals: [MealData]
}

struct MealData: Codable, Hashable {
    var mealID: String
    var meal: String
    var mealThumb: String
    
    private enum CodingKeys: String, CodingKey {
        case mealID = "idMeal", meal = "strMeal", mealThumb = "strMealThumb"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        mealID = try container.decode(String.self, forKey: .mealID)
        meal = try container.decode(String.self, forKey: .meal)
        mealThumb = try container.decode(String.self, forKey: .mealThumb)
    }
    
    // Custom initializer
    init(mealID: String, meal: String, mealThumb: String) {
        self.mealID = mealID
        self.meal = meal
        self.mealThumb = mealThumb
    }
}

struct MealDetailData: Codable {
    var meals: [MealDetail]
}

struct MealDetail: Codable, Hashable {
    var meal: String
    var instructions: String
    var mealThumb: String
    var ingredients: [String: String] = [:]
    
    private enum CodingKeys: String, CodingKey {
        case meal = "strMeal", instructions = "strInstructions", mealThumb = "strMealThumb"
    }
    
    init(meal: String, instructions: String, mealThumb: String, ingredients: [String: String]) {
        self.meal = meal
        self.instructions = instructions
        self.mealThumb = mealThumb
        self.ingredients = ingredients
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        meal = try container.decode(String.self, forKey: .meal)
        instructions = try container.decode(String.self, forKey: .instructions)
        mealThumb = try container.decode(String.self, forKey: .mealThumb)
        
        // Decode ingredients and measurements
        // Used dynamic coding keys to decode multiple ingredients, this simplified the code.
        let additionalContainer = try decoder.container(keyedBy: DynamicCodingKeys.self)
        for i in 1...20 {
            let ingredientKey = DynamicCodingKeys(stringValue: "strIngredient\(i)")!
            let measureKey = DynamicCodingKeys(stringValue: "strMeasure\(i)")!
            if let ingredient = try additionalContainer.decodeIfPresent(String.self, forKey: ingredientKey),
               !ingredient.isEmpty,
               let measure = try additionalContainer.decodeIfPresent(String.self, forKey: measureKey),
               !measure.isEmpty {
                ingredients[ingredient] = measure
            }
        }
    }
    
    struct DynamicCodingKeys: CodingKey {
        var stringValue: String
        var intValue: Int?
        
        init?(stringValue: String) {
            self.stringValue = stringValue
            self.intValue = nil
        }
        
        init?(intValue: Int) {
            self.intValue = intValue
            self.stringValue = "\(intValue)"
        }
    }
}
