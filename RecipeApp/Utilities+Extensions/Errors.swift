//
//  Errors.swift
//  RecipeApp
//
//  Created by Admin on 7/2/24.
//

import Foundation

enum APIError: Error {
    case failedToGetData
    case decodingError
    
    var localizedDescription: String {
        switch self {
        case .failedToGetData:
            return NSLocalizedString("Failed to retrieve data from the API. Please check your internet connection and try again.", comment: "API data retrieval error")
        case .decodingError:
            return NSLocalizedString("An error occurred while processing the API response. Error details: ", comment: "API decoding error")
        }
    }
}
