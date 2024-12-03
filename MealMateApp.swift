//
//  MealMateApp.swift
//  MealMate
//
//  Created by Caroline Begg on 11/18/24.
//

import SwiftUI

@main
struct MealMateApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
