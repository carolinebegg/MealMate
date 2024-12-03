//
//  FridgeViewModel.swift
//  MealMate
//
//  Created by Caroline Begg on 12/3/24.
//

import Foundation
import CoreData

class FridgeViewModel: ObservableObject {
    private let viewContext: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.viewContext = context
    }
    
    func addIngredient(name: String, expirationDate: Date?) {
        let ingredient = Ingredient(context: viewContext)
        ingredient.name = name
        ingredient.expirationDate = expirationDate
        
        saveContext()
    }
    
    func updateIngredient(_ ingredient: Ingredient, name: String, expirationDate: Date?) {
        ingredient.name = name
        ingredient.expirationDate = expirationDate
        saveContext()
    }
    
    func deleteIngredient(_ ingredient: Ingredient) {
        viewContext.delete(ingredient)
        saveContext()
    }
    
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
}
