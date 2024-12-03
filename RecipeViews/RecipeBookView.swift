//
//  RecipeBookView.swift
//  MealMate
//
//  Created by Caroline Begg on 12/3/24.
//

import SwiftUI

struct RecipeBookView: View {
    var body: some View {
        NavigationView {
            List {
                Text("Recipe 1")
                Text("Recipe 2")
                Text("Recipe 3")
            }
            .navigationTitle("Recipe Book")
            .toolbar {
                Button(action: {
                    // Add recipe action
                }) {
                    Image(systemName: "plus")
                }
            }
        }
    }
}
