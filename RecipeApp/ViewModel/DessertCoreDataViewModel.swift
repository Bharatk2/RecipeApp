//
//  DessertCoreDataViewModel.swift
//  RecipeApp
//
//  Created by Admin on 7/2/24.
//

import CoreData
import SwiftUI

class DessertCoreDataViewModel: ObservableObject {
    let container: NSPersistentContainer
    @Published var savedEntity: [DessertEntity] = []

    init() {
        container = NSPersistentContainer(name: "Dessert")
        container.loadPersistentStores { description, error in
            if let error = error  {
                print(error.localizedDescription)
            } else {
                print("success")
            }
        }

    }

}
