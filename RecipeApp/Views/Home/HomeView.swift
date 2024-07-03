//
//  HomeView.swift
//  RecipeApp
//
//  Created by Admin on 7/2/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var dessertViewModel: DessertViewModel
    @State private var searchText: String = ""
    var columns = [GridItem(.adaptive(minimum: 150),spacing: 40)]
    
    var filteredMeals: [MealData] {
        if searchText.isEmpty {
            return dessertViewModel.meals
        } else {
            return dessertViewModel.meals.filter { $0.meal.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        NavigationStack {
            VStack {
                SearchBar(text: $searchText)
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(filteredMeals, id: \.self) { meal in
                            MealScrollView(mealModel: meal)
                        }
                    }
                }
                .navigationBarTitle("Home🍰")
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            TextField("Search meals...", text: $text)
                .padding(7)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 10)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    
    static var previews: some View {
        let dessertPreviewCheck = DessertViewModel()
        HomeView()
            .environmentObject(dessertPreviewCheck)
    }
}

