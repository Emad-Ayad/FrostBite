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
}
