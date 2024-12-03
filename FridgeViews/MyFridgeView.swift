//
//  MyFridgeView.swift
//  MealMate
//
//  Created by Caroline Begg on 12/3/24.
//

import SwiftUI

struct MyFridgeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Ingredient.name, ascending: true)],
        animation: .default)
    private var ingredients: FetchedResults<Ingredient>
    
    @State private var showingAddSheet = false
    @State private var selectedIngredient: Ingredient?
    @State private var showingIngredientList = false
        
    var body: some View {
        NavigationView {
            VStack {
                if ingredients.isEmpty {
                    EmptyStateView()
                } else {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 20) {
                            ForEach(ingredients) { ingredient in
                                FridgeItemView(ingredient: ingredient)
                                    .onTapGesture {
                                        selectedIngredient = ingredient
                                    }
                                    .contextMenu {
                                        Button(role: .destructive) {
                                            deleteItem(ingredient)
                                        } label: {
                                            Label("Delete", systemImage: "trash")
                                        }
                                    }
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("My Fridge")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { showingIngredientList = true }) {
                        Image(systemName: "list.bullet")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddSheet = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddSheet) {
                AddEditIngredientView()
                    .environment(\.managedObjectContext, viewContext)
            }
            .sheet(item: $selectedIngredient) { ingredient in
                AddEditIngredientView(ingredient: ingredient)
                    .environment(\.managedObjectContext, viewContext)
            }
            .sheet(isPresented: $showingIngredientList) {
                NavigationView {
                    List {
                        ForEach(ingredients, id: \.id) { ingredient in
                            IngredientRowView(ingredient: ingredient)
                                .onTapGesture {
                                    selectedIngredient = ingredient
                                    showingIngredientList = false
                                }
                        }
                        .onDelete(perform: deleteItems)
                    }
                    .navigationTitle("Ingredients List")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("Done") {
                                showingIngredientList = false
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func deleteItem(_ ingredient: Ingredient) {
        withAnimation {
            viewContext.delete(ingredient)
            try? viewContext.save()
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { ingredients[$0] }.forEach(viewContext.delete)
            try? viewContext.save()
        }
    }
}
