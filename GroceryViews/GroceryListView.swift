//
//  GroceryListView.swift
//  MealMate
//
//  Created by Caroline Begg on 12/3/24.
//

//import SwiftUI
//import CoreData
//
//struct GroceryListView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Grocery.name, ascending: true)],
//        animation: .default)
//    private var groceries: FetchedResults<Grocery>
//
//    @State private var showingAddSheet = false
//    @State private var selectedGrocery: Grocery?
//
//    var body: some View {
//        NavigationView {
//            List {
//                ForEach(groceries, id: \.id) { grocery in
//                    GroceryRowView(grocery: grocery)
//                        .onTapGesture {
//                            selectedGrocery = grocery
//                        }
//                }
//                .onDelete(perform: deleteItems)
//            }
//            .onChange(of: groceries.count) { _ in
//                print("Groceries updated, count: \(groceries.count)")
//            }
//            .navigationTitle("Grocery List")
//            .toolbar {
//                Button {
//                    showingAddSheet = true
//                } label: {
//                    Image(systemName: "plus")
//                }
//            }
//        }
//        .sheet(isPresented: $showingAddSheet) {
//            AddEditGroceryView()
//                .environment(\.managedObjectContext, viewContext)
//        }
//        .sheet(item: $selectedGrocery) { grocery in
//            AddEditGroceryView(grocery: grocery)
//                .environment(\.managedObjectContext, viewContext)
//        }
//    }
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { groceries[$0] }.forEach(viewContext.delete)
//            try? viewContext.save()
//        }
//    }
//}

import SwiftUI
import CoreData

struct GroceryListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Grocery.name, ascending: true)],
        animation: .default)
    private var groceries: FetchedResults<Grocery>

    @State private var showingAddSheet = false
    @State private var selectedGrocery: Grocery?

    var body: some View {
        NavigationView {
            List {
                ForEach(groceries) { grocery in
                    GroceryRowView(grocery: grocery)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            selectedGrocery = grocery
                        }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("Grocery List")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddSheet = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddSheet) {
                AddEditGroceryView()
                    .environment(\.managedObjectContext, viewContext)
            }
            .sheet(item: $selectedGrocery) { grocery in
                AddEditGroceryView(grocery: grocery)
                    .environment(\.managedObjectContext, viewContext)
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { groceries[$0] }.forEach(viewContext.delete)
            do {
                try viewContext.save()
            } catch {
                // Handle the error appropriately in your app
                print("Error saving context after deletion: \(error)")
            }
        }
    }
}
