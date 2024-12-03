//
//  AddEditIngredientView.swift
//  MealMate
//
//  Created by Caroline Begg on 12/3/24.
//

import SwiftUI

struct AddEditIngredientView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    let ingredient: Ingredient?
    
    @StateObject private var foodSearch = FoodSearchService()
    @State private var name: String = ""
    @State private var quantity: String = "1"
    @State private var unit: String = "unit"
    @State private var expirationDate: Date = Date()
    @State private var hasExpirationDate = false
    @State private var searchText: String = ""
    
    init(ingredient: Ingredient? = nil) {
        self.ingredient = ingredient
        _name = State(initialValue: ingredient?.name ?? "")
        _quantity = State(initialValue: String(ingredient?.quantity ?? 1))
        _unit = State(initialValue: ingredient?.unit ?? "unit")
        _hasExpirationDate = State(initialValue: ingredient?.expirationDate != nil)
        _expirationDate = State(initialValue: ingredient?.expirationDate ?? Date())
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Search section
                    if ingredient == nil {
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
                    }
                    
                    // Name field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Name")
                            .foregroundColor(.gray)
                            .font(.subheadline)
                        CustomTextField(placeholder: "Enter ingredient name", text: $name, icon: "pencil")
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
            .navigationTitle(ingredient == nil ? "Add Ingredient" : "Edit Ingredient")
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
        
        if let ingredient = ingredient {
            ingredient.name = name
            ingredient.quantity = quantityDouble
            ingredient.unit = unit
            ingredient.expirationDate = hasExpirationDate ? expirationDate : nil
        } else {
            let newIngredient = Ingredient(context: viewContext)
            newIngredient.id = UUID()
            newIngredient.name = name
            newIngredient.quantity = quantityDouble
            newIngredient.unit = unit
            newIngredient.expirationDate = hasExpirationDate ? expirationDate : nil
        }
        
        do {
            try viewContext.save()
        } catch {
            print("Error saving ingredient: \(error)")
        }
    }
}
