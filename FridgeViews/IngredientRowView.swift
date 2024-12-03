//
//  IngredientRowView.swift
//  MealMate
//
//  Created by Caroline Begg on 12/3/24.
//

import SwiftUI
//
//struct IngredientRowView: View {
//    @ObservedObject var ingredient: Ingredient
//    
//    var body: some View {
//        HStack {
//            VStack(alignment: .leading, spacing: 4) {
//                Text(ingredient.name ?? "Unnamed")
//                if let expirationDate = ingredient.expirationDate {
//                    Text("Expires: \(expirationDate.formatted(date: .abbreviated, time: .omitted))")
//                        .font(.caption)
//                        .foregroundColor(.secondary)
//                }
//            }
//            Spacer()
//        }
//        .contentShape(Rectangle())
//        .padding(.vertical, 4)
//    }
//}
struct IngredientRowView: View {
    @ObservedObject var ingredient: Ingredient
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(ingredient.name ?? "Unnamed")
                HStack {
                    Text("\(String(format: "%.1f", ingredient.quantity)) \(ingredient.unit ?? "unit")")
                        .foregroundColor(.secondary)
                        .font(.subheadline)
                    
                    if let expirationDate = ingredient.expirationDate {
                        Text("•")
                            .foregroundColor(.secondary)
                        Text(expirationDate, format: .dateTime.month().day().year())
                            .foregroundColor(.secondary)
                            .font(.subheadline)
                    }
                }
            }
            Spacer()
        }
        .contentShape(Rectangle())
        .padding(.vertical, 4)
    }
}
