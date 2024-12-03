//
//  FridgeItemView.swift
//  MealMate
//
//  Created by Caroline Begg on 12/3/24.
//

import SwiftUI

struct FridgeItemView: View {
    let ingredient: Ingredient
    
    var body: some View {
        VStack {
            Text(iconForIngredient(ingredient.name ?? ""))
                .font(.system(size: 40))
            
            VStack(spacing: 2) {
                Text(ingredient.name ?? "Unknown")
                    .font(.caption)
                    .lineLimit(1)
                Text("\(String(format: "%.1f", ingredient.quantity)) \(ingredient.unit)")
                    .font(.caption2)
                    .foregroundColor(.secondary)
                
                if let expirationDate = ingredient.expirationDate {
                    Text(expirationDate, format: .dateTime.month().day())
                        .font(.caption2)
                        .foregroundColor(isExpiringSoon(date: expirationDate) ? .orange : .secondary)
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 3)
    }
    
    private func isExpiringSoon(date: Date) -> Bool {
        let days = Calendar.current.dateComponents([.day], from: Date(), to: date).day ?? 0
        return days <= 3 && days >= 0
    }
    
    private func iconForIngredient(_ name: String) -> String {
        let lowercasedName = name.lowercased()
        
        switch lowercasedName {
        case let name where name.contains("milk"):
            return "🥛"
        case let name where name.contains("cheese"):
            return "🧀"
        case let name where name.contains("egg"):
            return "🥚"
        case let name where name.contains("butter"):
            return "🧈"
        case let name where name.contains("meat") || name.contains("chicken"):
            return "🍗"
        case let name where name.contains("fish") || name.contains("salmon"):
            return "🐟"
        case let name where name.contains("apple"):
            return "🍎"
        case let name where name.contains("carrot"):
            return "🥕"
        case let name where name.contains("lettuce"):
            return "🥬"
        case let name where name.contains("tomato"):
            return "🍅"
        default:
            return "🥘"
        }
    }
}
