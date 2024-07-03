//
//  ButtonModifier.swift
//  RecipeApp
//
//  Created by Admin on 7/2/24.
//

import SwiftUI

struct ButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 15))
            .foregroundColor(.white)
            .frame(width: 200,height: 50)
            .background(Color.purple)
            .cornerRadius(999.0)
        
    }
}
