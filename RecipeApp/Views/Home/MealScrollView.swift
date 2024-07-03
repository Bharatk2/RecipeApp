//
//  MealScrollView.swift
//  RecipeApp
//
//  Created by Admin on 7/2/24.
//

import SwiftUI

struct MealScrollView: View {
    var mealModel: MealData
    
    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            Text(mealModel.meal)
                .font(.system(size: 10))
                .font(.headline)
                .fontWeight(.bold)
                .frame(width:100)
            ///Used  async images
            HStack {
                let url = mealModel.mealThumb
                AsyncImage(url: URL(string: url)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100,height: 130)
                        .cornerRadius(25)
                } placeholder: {
                    ProgressView()
                }
            }
        }
    }
}
