//
//  MealPlannerView.swift
//  MealMate
//
//  Created by Caroline Begg on 12/3/24.
//

import SwiftUI

struct MealPlannerView: View {
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Monday")) {
                    Text("Breakfast: -")
                    Text("Lunch: -")
                    Text("Dinner: -")
                }
                
                Section(header: Text("Tuesday")) {
                    Text("Breakfast: -")
                    Text("Lunch: -")
                    Text("Dinner: -")
                }
            }
            .navigationTitle("Meal Planner")
            .toolbar {
                Button(action: {
                    // Add meal action
                }) {
                    Image(systemName: "plus")
                }
            }
        }
    }
}
