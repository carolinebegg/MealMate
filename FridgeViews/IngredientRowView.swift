//
//  IngredientRowView.swift
//  MealMate
//
//  Created by Caroline Begg on 12/3/24.
//

import SwiftUI

struct IngredientRowView: View {
    @ObservedObject var ingredient: Ingredient
    
    var body: some View {
        HStack {
            Text(iconForIngredient(ingredient.name ?? ""))
                .font(.largeTitle)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(ingredient.name ?? "Unnamed")
                    .font(.headline)
                HStack {
                    Text(formattedQuantity(ingredient.quantity) + " " + (ingredient.unit ?? ""))
                        .foregroundColor(.secondary)
                        .font(.subheadline)
                    
                    if let expirationDate = ingredient.expirationDate {
                        Text("•")
                            .foregroundColor(.secondary)
                        Text(expirationDate, style: .date)
                            .foregroundColor(.secondary)
                            .font(.subheadline)
                    }
                }
            }
            Spacer()
        }
        .padding(.vertical, 8)
    }
    
    private func formattedQuantity(_ quantity: Double) -> String {
        if quantity.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f", quantity)
        } else {
            return String(format: "%.2f", quantity)
        }
    }
}
