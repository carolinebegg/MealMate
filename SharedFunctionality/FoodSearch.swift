//
//  FoodSearch.swift
//  MealMate
//
//  Created by Caroline Begg on 12/3/24.
//

import Foundation

struct FoodSearchResponse: Codable {
    let foods: [FoodItem]
}

struct FoodItem: Codable, Identifiable {
    let fdcId: Int
    let description: String
    let brandOwner: String?
    
    var id: Int { fdcId }
    
    // Make a clean display name from the description
    var displayName: String {
        description.capitalized
            .replacingOccurrences(of: ", UPC: \\d+", with: "", options: .regularExpression)
            .trimmingCharacters(in: .whitespaces)
    }
}
