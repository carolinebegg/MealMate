//
//  Custom.swift
//  MealMate
//
//  Created by Caroline Begg on 12/3/24.
//

import SwiftUI
import Foundation

struct CustomSearchBar: View {
    @Binding var text: String
    var placeholder: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            TextField(placeholder, text: $text)
                .autocapitalization(.none)
                .disableAutocorrection(true)
            
            if !text.isEmpty {
                Button(action: {
                    text = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(10)
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}

struct CustomTextField: View {
    let placeholder: String
    @Binding var text: String
    let icon: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.gray)
                .frame(width: 24)
            
            TextField(placeholder, text: $text)
                .autocapitalization(.words)
        }
        .padding(10)
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}

struct CustomQuantityField: View {
    @Binding var quantity: String
    @Binding var unit: String
    
    let units = ["unit", "g", "kg", "oz", "lb", "ml", "L", "cup", "tbsp", "tsp", "bottle", "jar", "can", "bag", "loaf", "bar"]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Quantity")
                .foregroundColor(.gray)
                .font(.subheadline)
            
            HStack {
                HStack {
                    Image(systemName: "number")
                        .foregroundColor(.gray)
                        .frame(width: 24)
                    
                    TextField("Amount", text: $quantity)
                        .keyboardType(.decimalPad)
                }
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                
                Menu {
                    Picker("Unit", selection: $unit) {
                        ForEach(units, id: \.self) { unit in
                            Text(unit).tag(unit)
                        }
                    }
                } label: {
                    Text(unit)
                        .padding(10)
                        .frame(minWidth: 60)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                }
            }
        }
    }
}

struct CustomDatePicker: View {
    @Binding var date: Date
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            DatePicker("", selection: $date, displayedComponents: .date)
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(10)
        }
    }
}

func iconForIngredient(_ name: String) -> String {
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
    case let name where name.contains("fish") || name.contains("salmon") || name.contains("tuna"):
        return "🐟"
    case let name where name.contains("apple"):
        return "🍎"
    case let name where name.contains("banana"):
        return "🍌"
    case let name where name.contains("carrot"):
        return "🥕"
    case let name where name.contains("lettuce") || name.contains("spinach") || name.contains("kale"):
        return "🥬"
    case let name where name.contains("tomato"):
        return "🍅"
    case let name where name.contains("potato"):
        return "🥔"
    case let name where name.contains("pepper") || name.contains("chili"):
        return "🌶️"
    case let name where name.contains("grape"):
        return "🍇"
    case let name where name.contains("orange"):
        return "🍊"
    case let name where name.contains("lemon") || name.contains("lime"):
        return "🍋"
    case let name where name.contains("strawberry"):
        return "🍓"
    case let name where name.contains("blueberry") || name.contains("berry"):
        return "🫐"
    case let name where name.contains("watermelon"):
        return "🍉"
    case let name where name.contains("pineapple"):
        return "🍍"
    case let name where name.contains("peach"):
        return "🍑"
    case let name where name.contains("coconut"):
        return "🥥"
    case let name where name.contains("bread"):
        return "🍞"
    case let name where name.contains("rice"):
        return "🍚"
    case let name where name.contains("pasta") || name.contains("spaghetti") || name.contains("noodle"):
        return "🍝"
    case let name where name.contains("burger"):
        return "🍔"
    case let name where name.contains("pizza"):
        return "🍕"
    case let name where name.contains("soup"):
        return "🍲"
    case let name where name.contains("cake"):
        return "🍰"
    case let name where name.contains("cookie"):
        return "🍪"
    case let name where name.contains("ice cream") || name.contains("gelato"):
        return "🍨"
    case let name where name.contains("chocolate"):
        return "🍫"
    case let name where name.contains("coffee") || name.contains("espresso"):
        return "☕"
    case let name where name.contains("tea"):
        return "🍵"
    case let name where name.contains("juice"):
        return "🧃"
    case let name where name.contains("wine"):
        return "🍷"
    case let name where name.contains("beer"):
        return "🍺"
    case let name where name.contains("water"):
        return "💧"
    case let name where name.contains("soda") || name.contains("cola"):
        return "🥤"
    case let name where name.contains("popcorn"):
        return "🍿"
    case let name where name.contains("corn"):
        return "🌽"
    case let name where name.contains("mushroom"):
        return "🍄"
    case let name where name.contains("shrimp") || name.contains("prawn"):
        return "🍤"
    case let name where name.contains("bacon"):
        return "🥓"
    case let name where name.contains("steak") || name.contains("beef"):
        return "🥩"
    case let name where name.contains("honey"):
        return "🍯"
    case let name where name.contains("avocado"):
        return "🥑"
    default:
        return "🥘"
    }
}

