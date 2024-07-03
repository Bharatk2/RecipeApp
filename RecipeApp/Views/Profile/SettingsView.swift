//
//  SettingsView.swift
//  RecipeApp
//
//  Created by Admin on 7/2/24.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("onboarding") var isonBoardingViewActive:Bool = true
    @AppStorage("UserName") var userName = "Username"
    @AppStorage("Twitter") var twitterHandle = "@TwitterHandle"
    @AppStorage("email") var emailAddress = "user@domain.com"
    @AppStorage("Location") var location = "Location"
    @Binding var dismissSheet: Bool
    @State private var signoutToggle = false
    @State private var newUserName = ""
    @State private var newTwitterHandle = ""
    @State private var newEmail = ""
    @State private var newlocation = ""
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    SettingsView(dismissSheet: .constant(false))
}
