//
//  ContentView.swift
//  MealMate
//
//  Created by Caroline Begg on 11/18/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        TabView {
            MyFridgeView()
                .environment(\.managedObjectContext, viewContext)
                .tabItem {
                    Label("My Fridge", systemImage: "refrigerator")
                }
            
            RecipeBookView()
                .environment(\.managedObjectContext, viewContext)
                .tabItem {
                    Label("Recipes", systemImage: "book")
                }
            
            MealPlannerView()
                .environment(\.managedObjectContext, viewContext)
                .tabItem {
                    Label("Meal Plan", systemImage: "calendar")
                }
            
            GroceryListView()
                .environment(\.managedObjectContext, viewContext)
                .tabItem {
                    Label("Grocery List", systemImage: "cart")
                }
        }
    }
}
