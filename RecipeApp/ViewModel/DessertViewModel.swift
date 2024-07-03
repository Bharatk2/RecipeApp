//
//  DessertViewModel.swift
//  RecipeApp
//
//  Created by Admin on 7/2/24.
//

import Foundation
import Combine

@MainActor
class DessertViewModel: ObservableObject {
    @Published var meals: [MealData] = []
    @Published var mealsDetail: [MealDetail] = []
    @Published var isLoading = false // Add a flag to indicate loading state
    @Published var errorDetail: String? = nil // Add a property to store error message
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        Task {
            await fetch()
        }
    }
    
    public func fetch() async {
        isLoading = true // Set loading state to true
        defer { isLoading = false } // Set loading state to false on completion (even in case of error)
        do {
            let desserts = try await APICaller.shared.getAllDessertCategory()
            meals = desserts
        } catch let error {
            errorDetail = error.localizedDescription // Store error message
            print(error.localizedDescription) // Log the error for debugging
        }
    }
    
    public func fetchDetails(id: String) async {
        isLoading = true
        defer { isLoading = false }
        do {
            let dessertDetail = try await APICaller.shared.getDessertDetail(id: id)
            mealsDetail = dessertDetail
        } catch {
            errorDetail = error.localizedDescription
            print(error.localizedDescription)
        }
    }
}
