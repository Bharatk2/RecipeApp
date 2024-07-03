//
//  TabBarView.swift
//  RecipeApp
//
//  Created by Admin on 7/2/24.
//

import SwiftUI

struct TabBarView: View {
    @StateObject var dessertViewModel = DessertViewModel()
    @StateObject var  dessertcore = DessertCoreDataViewModel()
    @AppStorage("onboarding") var isOnBoardingViewActive: Bool = true
    
    var body: some View {
        TabView {
            HomeView()
                .environmentObject(dessertViewModel)
                .environmentObject(dessertcore)
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }

            FavoriteMealView()
                .environmentObject(dessertcore)
                .tabItem {
                    Image(systemName: "books.vertical.fill")
                    Text("Favorites")
                }

            ProfileView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
        }
        .onAppear(perform: {
            isOnBoardingViewActive = true
        })
        .accentColor(.purple)
    }
}

#Preview {
    TabBarView()
}
