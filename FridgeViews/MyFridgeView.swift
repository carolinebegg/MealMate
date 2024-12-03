//
//  MyFridgeView.swift
//  MealMate
//
//  Created by Caroline Begg on 12/3/24.
//

//import SwiftUI
//import CoreData
//
//struct MyFridgeView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Ingredient.name, ascending: true)],
//        animation: .default)
//    private var ingredients: FetchedResults<Ingredient>
//    
//    @State private var showingAddSheet = false
//    @State private var selectedIngredient: Ingredient?
//    
//    var body: some View {
//        NavigationView {
//            List {
//                ForEach(ingredients, id: \.id) { ingredient in
//                    IngredientRowView(ingredient: ingredient)
//                        .onTapGesture {
//                            selectedIngredient = ingredient
//                        }
//                }
//                .onDelete(perform: deleteItems)
//            }
//            .onChange(of: ingredients.count) { _ in
//                print("Ingredients updated, count: \(ingredients.count)")
//            }
//            .navigationTitle("My Fridge")
//            .toolbar {
//                Button {
//                    showingAddSheet = true
//                } label: {
//                    Image(systemName: "plus")
//                }
//            }
//        }
//        .sheet(isPresented: $showingAddSheet) {
//            AddEditIngredientView()
//                .environment(\.managedObjectContext, viewContext)
//        }
//        .sheet(item: $selectedIngredient) { ingredient in
//            AddEditIngredientView(ingredient: ingredient)
//                .environment(\.managedObjectContext, viewContext)
//        }
//    }
//    
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { ingredients[$0] }.forEach(viewContext.delete)
//            try? viewContext.save()
//        }
//    }
//}

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
            ZStack {
                // Fridge background
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(.systemGray6))
                    .shadow(radius: 10)
                    .padding()
                
                VStack {
                    // Fridge handle
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color(.systemGray3))
                        .frame(width: 60, height: 120)
                        .padding(.trailing, -20)
                        .padding(.top, 40)
                    
                    // Fridge contents
                    ScrollView {
                        LazyVGrid(columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ], spacing: 20) {
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
                
                // Add button
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: { showingAddSheet = true }) {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .frame(width: 60, height: 60)
                                .foregroundColor(.blue)
                                .background(Color.white)
                                .clipShape(Circle())
                                .shadow(radius: 5)
                        }
                        .padding()
                    }
                }
                
                // List view button
                VStack {
                    Spacer()
                    HStack {
                        Button(action: { showingIngredientList = true }) {
                            Image(systemName: "list.bullet.circle.fill")
                                .resizable()
                                .frame(width: 60, height: 60)
                                .foregroundColor(.blue)
                                .background(Color.white)
                                .clipShape(Circle())
                                .shadow(radius: 5)
                        }
                        .padding()
                        Spacer()
                    }
                }
            }
            .navigationTitle("My Fridge")
            .onChange(of: ingredients.count) { _ in
                print("Ingredients updated, count: \(ingredients.count)")
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
                    Button("Done") {
                        showingIngredientList = false
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
