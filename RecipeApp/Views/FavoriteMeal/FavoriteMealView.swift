//
//  FavoriteMealView.swift
//  RecipeApp
//
//  Created by Admin on 7/2/24.
//

import SwiftUI

struct FavoriteMealView: View {
    @EnvironmentObject var dessertCoreDataModel: DessertCoreDataViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(dessertCoreDataModel.savedEntity) { dessert in
                    VStack(spacing: 10) {
                        HStack {
                            Text("Name💎")
                            Spacer()
                            Text(dessert.name ?? "")
                        }
                    }
                }
                .onDelete(perform: dessertCoreDataModel.delete)
                .listStyle(.plain)
            }
        }
        .navigationBarTitle("Favorites")
        .onAppear{
            dessertCoreDataModel.fetchDessert()
        }
    }
}

struct FavoriteMealView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteMealView().environmentObject(DessertCoreDataViewModel())
    }
}
