//
//  MealDescriptionDetail.swift
//  RecipeApp
//
//  Created by Admin on 7/2/24.
//

import SwiftUI

struct MealDescriptionDetail: View {
    var mealDetail: String?
    @StateObject var dessertViewModel = DessertViewModel()
    
    var body: some View {
        NavigationView{
            ForEach(dessertViewModel.mealsDetail ,id:\.self) { meal in
                MealDescriptionView(mealDetail: meal)
                    .frame(maxWidth:.infinity,maxHeight: .infinity)
            }
            
        }
        .onAppear{
            Task {
                await dessertViewModel.fetchDetails(id: mealDetail ?? "")
            }
        }
    }
}

#Preview {
    MealDescriptionDetail()
}
