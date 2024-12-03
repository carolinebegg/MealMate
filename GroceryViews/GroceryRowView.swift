//
//  GroceryRowView.swift
//  MealMate
//
//  Created by Caroline Begg on 12/3/24.
//

//import SwiftUI
//
//struct GroceryRowView: View {
//    @ObservedObject var grocery: Grocery
//    
//    var body: some View {
//        HStack {
//            VStack(alignment: .leading, spacing: 4) {
//                Text(grocery.name ?? "Unnamed")
//                HStack {
//                    Text("\(String(format: "%.1f", grocery.quantity)) \(grocery.unit ?? "unit")")
//                        .foregroundColor(.secondary)
//                        .font(.subheadline)
//                    
//                    if let expirationDate = grocery.expirationDate {
//                        Text("•")
//                            .foregroundColor(.secondary)
//                        Text(expirationDate, format: .dateTime.month().day().year())
//                            .foregroundColor(.secondary)
//                            .font(.subheadline)
//                    }
//                }
//            }
//            Spacer()
//        }
//        .contentShape(Rectangle())
//        .padding(.vertical, 4)
//    }
//}

import SwiftUI

struct GroceryRowView: View {
    @ObservedObject var grocery: Grocery

    var body: some View {
        HStack {
            Button(action: {
                grocery.isChecked.toggle()
                // Save the context to persist changes
                try? grocery.managedObjectContext?.save()
            }) {
                Image(systemName: grocery.isChecked ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(grocery.isChecked ? .blue : .gray)
                    .font(.title2)
            }
            .buttonStyle(PlainButtonStyle())

            VStack(alignment: .leading, spacing: 4) {
                Text(grocery.name ?? "Unnamed")
                    .strikethrough(grocery.isChecked, color: .gray)
                    .foregroundColor(grocery.isChecked ? .gray : .primary)
                    .font(.headline)

                HStack {
                    Text("\(String(format: "%.1f", grocery.quantity)) \(grocery.unit ?? "unit")")
                        .foregroundColor(.secondary)
                        .font(.subheadline)

                    if let expirationDate = grocery.expirationDate {
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
        .contentShape(Rectangle())
        .padding(.vertical, 4)
    }
}
