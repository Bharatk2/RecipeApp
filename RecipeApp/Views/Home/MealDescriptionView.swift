//
//  MealDescriptionView.swift
//  RecipeApp
//
//  Created by Admin on 7/2/24.
//

import SwiftUI
import CoreData

struct MealDescriptionView: View {
    @EnvironmentObject var dessertCoreData: DessertCoreDataViewModel
    @State private var dataSavedPresented = false
    @State private var isFavorite: Bool = false
    
    var mealDetail: MealDetail?

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                HStack{
                    if let url = mealDetail?.mealThumb {
                        AsyncImage(url: URL(string: url)) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(maxWidth: 250,maxHeight: 250)
                                .cornerRadius(8)
                            
                            
                        } placeholder: {
                            ProgressView()
                        }
                    }
                }
                
                if let mealDetail = mealDetail {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Name: \(mealDetail.meal)")
                            .foregroundStyle(
                                LinearGradient(colors: [.pink,.purple,.blue], startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                        
                        HStack {
                            Text("click to add favourite😁")
                            Button {
                                isFavorite.toggle()
                                dataSavedPresented = isFavorite
                                dessertCoreData.addDessert(name: mealDetail.meal, isFavorited: isFavorite)
                                
                                
                            } label: {
                                Image(systemName: isFavorite ? "heart.fill" : "heart")
                                    .foregroundColor(.red)
                            }
                        }
                        
                        Text("instructions")
                        ScrollView {
                            Text(mealDetail.instructions)
                                .foregroundColor(.red)
                                .lineLimit(nil)
                        }
                        Text("Ingredients:")
                            .font(.system(.headline))
                        ForEach(Array(mealDetail.ingredients.keys.sorted()), id: \.self) { key in
                            Text("\(key): \(mealDetail.ingredients[key]!)")
                        }
                        
                        
                    }
                }
            }
            .frame(maxWidth:.infinity,maxHeight:.infinity)
            .padding()
        }
        .onAppear {
            checkIfFavorite()
        }
        .alert("Recipe Saved", isPresented: $dataSavedPresented, actions: {
        })
    }
    
    // Check if the dessert is favorited onAppear of MealDescriptionView.
    private func checkIfFavorite() {
        guard let mealName = mealDetail?.meal else { return }
        let request = NSFetchRequest<DessertEntity>(entityName: "DessertEntity")
        request.predicate = NSPredicate(format: "name == %@", mealName)
        
        do {
            let existingDesserts = try dessertCoreData.container.viewContext.fetch(request)
            if let existingDessert = existingDesserts.first {
                isFavorite = existingDessert.isFavorited
            }
        } catch {
            print("Failed to fetch dessert: \(error.localizedDescription)")
        }
    }
}

struct MealDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        let dessertPreviewCheck = DessertCoreDataViewModel()
        MealDescriptionView()
            .environmentObject(dessertPreviewCheck)
    }
}
