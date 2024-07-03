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
        fetchDessert()
    }

    //fetch the request
    func fetchDessert() {
        let request =  NSFetchRequest<DessertEntity>(entityName:"DessertEntity")
        
        do {
            savedEntity = try container.viewContext.fetch(request)
        } catch let error {
            print(error.localizedDescription)
        }
    }

    //add the dessert
    func addDessert(name: String) {
        let newDessert = DessertEntity(context: container.viewContext)
        newDessert.name = name
        saveDessert()
    }

    //delete the dessert
    func delete(index: IndexSet) {
        guard let index = index.first else {return}
        let entity = savedEntity[index]
        container.viewContext.delete(entity)
        saveDessert()
    }
    
    //save the dessert
    func saveDessert() {
        do {
            try  container.viewContext.save()
            fetchDessert()
        } catch {
            print(error.localizedDescription)
        }
    }
}
