//
//  SearchViewModel.swift
//  FrostBite
//
//  Created by TaqieAllah on 05/06/2026.
//

import Foundation
import Combine
import SwiftData

@MainActor
final class SearchViewModel: ObservableObject {
    
    @Published var searchText = ""
    @Published var result: WeatherResponse?
    @Published var isLoading = false
    @Published var errorMessage = ""
    @Published var suggestions: [SearchResultDTO] = []
    private var suggestionTask: Task<Void, Never>?
    
    private let service = WeatherService()
    
    func search() async {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !query.isEmpty else { return }
        
        isLoading = true
        errorMessage = ""
        result = nil
        
        do {
            let weather = try await service.fetchWeather(for: query)
            result = weather
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func saveToFavourites(context: ModelContext, result: WeatherResponse) {
        let loc = result.location
        let saved = SavedLocation(
            query: loc.name,
            name: loc.name,
            region: loc.region,
            country: loc.country,
            lat: loc.lat,
            lon: loc.lon,
            isFavorite: true
        )
        context.insert(saved)
        try? context.save()
    }
    
    func fetchSuggestions() async {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard query.count >= 2 else {
            suggestions = []
            result = nil
            return
        }

        suggestionTask?.cancel()
        suggestionTask = Task {
            try? await Task.sleep(for: .milliseconds(300))  
            guard !Task.isCancelled else { return }
            suggestions = (try? await service.searchCities(for: query)) ?? []
        }
    }
}
