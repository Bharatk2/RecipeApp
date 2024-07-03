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
        NavigationView {
            VStack {
                Text("Update user information:").font(.title2)
                TextField("Username", text: $newUserName).textFieldStyle(.roundedBorder)
                TextField("Twitter", text: $newTwitterHandle).textFieldStyle(.roundedBorder)
                TextField("E-Mail", text: $newEmail).textFieldStyle(.roundedBorder).textInputAutocapitalization(.never)
                TextField("Loaction", text: $newlocation ).textFieldStyle(.roundedBorder).textInputAutocapitalization(.never)

                Button("Save") {
                    if !newUserName.isEmpty || !newTwitterHandle.isEmpty || !location.isEmpty || !newEmail.isEmpty {
                        userName = newUserName
                        twitterHandle = newTwitterHandle
                        emailAddress = newEmail
                        location = newlocation
                        dismissSheet = false
                    }
                }.buttonStyle(.bordered)
                Spacer()
            }
            .padding()
            .navigationTitle(Text("Profile"))
        }
    }
}

#Preview {
    SettingsView(dismissSheet: .constant(false))
}
