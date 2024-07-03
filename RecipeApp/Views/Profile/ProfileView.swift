//
//  ProfileView.swift
//  RecipeApp
//
//  Created by Admin on 7/2/24.
//

import SwiftUI

struct ProfileView: View {
    @AppStorage("onboarding") var isOnBoardingViewActive: Bool = true
    @AppStorage("UserName") var userName = "Username"
    @AppStorage("Twitter") var twitterHandle = "twitterHandle"
    @AppStorage("email") var emailAddress = "user@domain.com"
    @AppStorage("Location") var location = "Location"
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    @State private var showAlertView: Bool = false
    @State private var updateUserIsPresented = false
    
    var body: some View {
        NavigationStack {
            List {
                VStack(alignment:.center) {
                    HStack {
                        Image(systemName:"person.circle.fill")
                            .font(.system(size: 50))
                        Spacer()
                        Button {
                            updateUserIsPresented = true
                            
                        } label: {
                            Text("Edit")
                        }
                    }
                    .popover(isPresented: $updateUserIsPresented) {
                        SettingsView(dismissSheet: $updateUserIsPresented)
                    }
                }
                HStack {
                    Text("Name:")
                    Spacer()
                    Text("\(userName)")
                }
                HStack {
                    Text("Twitter:")
                    Spacer()
                    Text("@\(twitterHandle)")
                }
                HStack {
                    Text("E-Mail:")
                    Spacer()
                    Text("\(emailAddress)")
                }
                HStack {
                    Text("Location")
                    Spacer()
                    Text(("\(location)"))
                }
            }.navigationBarTitle("Profile")
        }
    }
}

#Preview {
    ProfileView()
}
