//
//  WelcomeView.swift
//  RecipeApp
//
//  Created by Admin on 7/2/24.
//

import SwiftUI

struct WelcomeView: View {
    @AppStorage("onboarding") var isOnBoardingViewActive: Bool = true
    @Binding var nextScreen: Bool
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack(spacing: 100) {
                HStack {
                    Text("Are You Hungry?")
                        .font(.system(size: 30))
                        .foregroundStyle(
                            LinearGradient(colors: [.pink, .purple, .blue], startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                        .accessibilityIdentifier("hungryText")
                }
                Image("Hungry")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 300)
                    .border(.white, width: 2)
                    .accessibilityIdentifier("HungryImage")
                Button("Let's Eat") {
                    isOnBoardingViewActive = false
                    nextScreen = false
                }
                .accessibilityIdentifier("LetsEatButton")
            }
        }
    }
}


#Preview {
    WelcomeView(nextScreen: .constant(false))
}
