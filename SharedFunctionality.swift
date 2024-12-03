//
//  SharedFunctionality.swift
//  MealMate
//
//  Created by Caroline Begg on 12/3/24.
//

import SwiftUI

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
    
    let units = ["unit", "g", "kg", "oz", "lb", "ml", "L", "cup", "tbsp", "tsp", "bottle", "jar", "can", "bag"]
    
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
