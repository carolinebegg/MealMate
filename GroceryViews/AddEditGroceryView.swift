//
//  AddEditGroceryView.swift
//  MealMate
//
//  Created by Caroline Begg on 12/3/24.
//

//import SwiftUI
//
//struct AddEditGroceryView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//    @Environment(\.dismiss) private var dismiss
//    
//    let grocery: Grocery?
//    
//    @StateObject private var foodSearch = FoodSearchService()
//    @State private var name: String = ""
//    @State private var quantity: String = "1"
//    @State private var unit: String = "unit"
//    @State private var expirationDate: Date = Date()
//    @State private var hasExpirationDate = false
//    @State private var searchText: String = ""
//    
//    init(grocery: Grocery? = nil) {
//        self.grocery = grocery
//        _name = State(initialValue: grocery?.name ?? "")
//        _quantity = State(initialValue: String(grocery?.quantity ?? 1))
//        _unit = State(initialValue: grocery?.unit ?? "unit")
//        _hasExpirationDate = State(initialValue: grocery?.expirationDate != nil)
//        _expirationDate = State(initialValue: grocery?.expirationDate ?? Date())
//    }
//    
//    var body: some View {
//        NavigationView {
//            ScrollView {
//                VStack(spacing: 20) {
//                    // Search section
//                    if grocery == nil {
//                        VStack(spacing: 16) {
//                            CustomSearchBar(text: $searchText, placeholder: "Search USDA Food Database")
//                            
//                            if foodSearch.isLoading {
//                                ProgressView()
//                                    .progressViewStyle(.circular)
//                            } else if !foodSearch.searchResults.isEmpty {
//                                VStack(alignment: .leading, spacing: 2) {
//                                    ForEach(foodSearch.searchResults) { food in
//                                        Button(action: {
//                                            name = food.displayName
//                                            searchText = ""
//                                        }) {
//                                            Text(food.displayName)
//                                                .foregroundColor(.primary)
//                                                .padding(.vertical, 8)
//                                                .padding(.horizontal, 12)
//                                                .frame(maxWidth: .infinity, alignment: .leading)
//                                        }
//                                        .background(Color(.systemBackground))
//                                        
//                                        if food.id != foodSearch.searchResults.last?.id {
//                                            Divider()
//                                        }
//                                    }
//                                }
//                                .background(Color(.systemGray6))
//                                .cornerRadius(10)
//                            }
//                        }
//                    }
//                    
//                    // Name field
//                    VStack(alignment: .leading, spacing: 8) {
//                        Text("Name")
//                            .foregroundColor(.gray)
//                            .font(.subheadline)
//                        CustomTextField(placeholder: "Enter grocery name", text: $name, icon: "pencil")
//                    }
//                    
//                    // Quantity field
//                    CustomQuantityField(quantity: $quantity, unit: $unit)
//                    
//                    // Expiration date section
//                    VStack(alignment: .leading, spacing: 8) {
//                        Toggle(isOn: $hasExpirationDate) {
//                            HStack {
//                                Image(systemName: "calendar")
//                                    .foregroundColor(.gray)
//                                    .frame(width: 24)
//                                Text("Expiration Date")
//                            }
//                        }
//                        .padding(10)
//                        .background(Color(.systemGray6))
//                        .cornerRadius(10)
//                        
//                        if hasExpirationDate {
//                            CustomDatePicker(date: $expirationDate)
//                                .transition(.opacity)
//                        }
//                    }
//                }
//                .padding()
//            }
//            .navigationTitle(grocery == nil ? "Add Grocery Item" : "Edit Grocery Item")
//            .toolbar {
//                ToolbarItem(placement: .cancellationAction) {
//                    Button("Cancel") {
//                        dismiss()
//                    }
//                }
//                ToolbarItem(placement: .confirmationAction) {
//                    Button("Save") {
//                        save()
//                        dismiss()
//                    }
//                    .disabled(name.isEmpty || quantity.isEmpty)
//                }
//            }
//        }
//        .onChange(of: searchText) { query in
//            Task {
//                await foodSearch.searchFoods(query)
//            }
//        }
//    }
//    
//    private func save() {
//        guard let quantityDouble = Double(quantity) else { return }
//        
//        if let grocery = grocery {
//            grocery.name = name
//            grocery.quantity = quantityDouble
//            grocery.unit = unit
//            grocery.expirationDate = hasExpirationDate ? expirationDate : nil
//        } else {
//            let newGrocery = Grocery(context: viewContext)
//            newGrocery.id = UUID()
//            newGrocery.name = name
//            newGrocery.quantity = quantityDouble
//            newGrocery.unit = unit
//            newGrocery.expirationDate = hasExpirationDate ? expirationDate : nil
//        }
//        
//        do {
//            try viewContext.save()
//        } catch {
//            print("Error saving grocery: \(error)")
//        }
//    }
//}


import SwiftUI

struct AddEditGroceryView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss

    let grocery: Grocery?

    @StateObject private var foodSearch = FoodSearchService()
    @State private var name: String = ""
    @State private var quantity: String = "1"
    @State private var unit: String = "unit"
    @State private var expirationDate: Date = Date()
    @State private var hasExpirationDate = false
    @State private var searchText: String = ""

    init(grocery: Grocery? = nil) {
        self.grocery = grocery
        _name = State(initialValue: grocery?.name ?? "")
        _quantity = State(initialValue: String(grocery?.quantity ?? 1))
        _unit = State(initialValue: grocery?.unit ?? "unit")
        _hasExpirationDate = State(initialValue: grocery?.expirationDate != nil)
        _expirationDate = State(initialValue: grocery?.expirationDate ?? Date())
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Search section
                    VStack(spacing: 16) {
                        CustomSearchBar(text: $searchText, placeholder: "Search USDA Food Database")

                        if foodSearch.isLoading {
                            ProgressView()
                                .progressViewStyle(.circular)
                        } else if !foodSearch.searchResults.isEmpty {
                            VStack(alignment: .leading, spacing: 2) {
                                ForEach(foodSearch.searchResults) { food in
                                    Button(action: {
                                        name = food.displayName
                                        searchText = ""
                                    }) {
                                        Text(food.displayName)
                                            .foregroundColor(.primary)
                                            .padding(.vertical, 8)
                                            .padding(.horizontal, 12)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                    .background(Color(.systemBackground))

                                    if food.id != foodSearch.searchResults.last?.id {
                                        Divider()
                                    }
                                }
                            }
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                        }
                    }

                    // Name field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Name")
                            .foregroundColor(.gray)
                            .font(.subheadline)
                        CustomTextField(placeholder: "Enter grocery name", text: $name, icon: "pencil")
                    }

                    // Quantity field
                    CustomQuantityField(quantity: $quantity, unit: $unit)

                    // Expiration date section
                    VStack(alignment: .leading, spacing: 8) {
                        Toggle(isOn: $hasExpirationDate) {
                            HStack {
                                Image(systemName: "calendar")
                                    .foregroundColor(.gray)
                                    .frame(width: 24)
                                Text("Expiration Date")
                            }
                        }
                        .padding(10)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)

                        if hasExpirationDate {
                            CustomDatePicker(date: $expirationDate)
                                .transition(.opacity)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle(grocery == nil ? "Add Grocery Item" : "Edit Grocery Item")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        save()
                        dismiss()
                    }
                    .disabled(name.isEmpty || quantity.isEmpty)
                }
            }
        }
        .onChange(of: searchText) { query in
            Task {
                await foodSearch.searchFoods(query)
            }
        }
    }

    private func save() {
        guard let quantityDouble = Double(quantity) else { return }

        if let grocery = grocery {
            // Editing existing grocery
            grocery.name = name
            grocery.quantity = quantityDouble
            grocery.unit = unit
            grocery.expirationDate = hasExpirationDate ? expirationDate : nil
        } else {
            // Creating new grocery
            let newGrocery = Grocery(context: viewContext)
            newGrocery.id = UUID()
            newGrocery.name = name
            newGrocery.quantity = quantityDouble
            newGrocery.unit = unit
            newGrocery.expirationDate = hasExpirationDate ? expirationDate : nil
            newGrocery.isChecked = false // Set default value
        }

        do {
            try viewContext.save()
            print("Grocery item saved successfully.")
        } catch {
            print("Error saving grocery: \(error.localizedDescription)")
        }
    }
}
