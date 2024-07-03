//
//  MainView.swift
//  RecipeApp
//
//  Created by Admin on 7/2/24.
//

import SwiftUI

struct MainView: View {
    @State var nextScreen: Bool = true
    var body: some View {
        ZStack {
            if nextScreen {
                WelcomeView(nextScreen: $nextScreen)
            } else {
                TabBarView()
            }
        }
    }
}

#Preview {
    MainView()
}
