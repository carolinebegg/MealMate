//
//  FoodSearchService.swift
//  MealMate
//
//  Created by Caroline Begg on 12/3/24.
//

import Foundation

// FoodSearchService.swift
class FoodSearchService: ObservableObject {
    private let apiKey = "d4vlFAH0XxgegEbw5iWI5et7dSDcwJvnvR16vnQj"
    private let baseURL = "https://api.nal.usda.gov/fdc/v1"
    
    @Published var searchResults: [FoodItem] = []
    @Published var isLoading = false
    @Published var error: Error?
    
    func searchFoods(_ query: String) async {
        guard !query.isEmpty else {
            await MainActor.run {
                searchResults = []
                isLoading = false
            }
            return
        }
        
        let queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "dataType", value: "Foundation,SR Legacy"),
            URLQueryItem(name: "pageSize", value: "10")
        ]
        
        var urlComps = URLComponents(string: "\(baseURL)/foods/search")!
        urlComps.queryItems = queryItems
        
        guard let url = urlComps.url else { return }
        
        await MainActor.run { isLoading = true }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode(FoodSearchResponse.self, from: data)
            
            await MainActor.run {
                searchResults = response.foods
                isLoading = false
                error = nil
            }
        } catch {
            await MainActor.run {
                self.error = error
                isLoading = false
                searchResults = []
            }
        }
    }
}
