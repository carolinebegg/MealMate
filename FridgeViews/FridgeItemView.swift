//
//  FridgeItemView.swift
//  MealMate
//
//  Created by Caroline Begg on 12/3/24.
//

import SwiftUI

struct FridgeItemView: View {
    @ObservedObject var ingredient: Ingredient
    private let itemWidth = (UIScreen.main.bounds.width - 48) / 2 // 48 accounts for padding and spacing
    private let itemHeight: CGFloat = 180
    
    var body: some View {
        VStack(spacing: 8) {
            Text(iconForIngredient(ingredient.name ?? ""))
                .font(.system(size: 50))
            
            Text(ingredient.name ?? "Unknown")
                .font(.headline)
                .multilineTextAlignment(.center)
                .lineLimit(2)
            
            Text(formattedQuantity(ingredient.quantity) + " " + (ingredient.unit ?? ""))
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            if let expirationDate = ingredient.expirationDate {
                Text(expirationDate, style: .date)
                    .font(.caption)
                    .foregroundColor(isExpiringSoon(date: expirationDate) ? .orange : .secondary)
            }
        }
        .padding()
        .frame(width: itemWidth, height: itemHeight)
        .background(Color(.systemBackground))
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
    }
    
    private func isExpiringSoon(date: Date) -> Bool {
        let days = Calendar.current.dateComponents([.day], from: Date(), to: date).day ?? 0
        return days <= 3 && days >= 0
    }
    
    private func formattedQuantity(_ quantity: Double) -> String {
        if quantity.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f", quantity)
        } else {
            return String(format: "%.2f", quantity)
        }
    }
}
