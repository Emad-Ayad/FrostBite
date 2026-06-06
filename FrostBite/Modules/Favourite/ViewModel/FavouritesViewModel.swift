//
//  FavouritesViewModel.swift
//  FrostBite
//
//  Created by TaqieAllah on 06/06/2026.
//

import Foundation
import SwiftData
import Combine

@MainActor
final class FavouritesViewModel: ObservableObject {

    @Published var favourites: [SavedLocation] = []
    @Published var weatherMap: [String: WeatherResponse] = [:]
    @Published var loadingSet: Set<String> = []

    private let service = WeatherService()

    func loadAll(from context: ModelContext) {
        let descriptor = FetchDescriptor<SavedLocation>(
            predicate: #Predicate { $0.isFavorite == true }
        )
        favourites = (try? context.fetch(descriptor)) ?? []
    }

    func loadWeather(for location: SavedLocation) async {
        guard weatherMap[location.query] == nil else { return }
        loadingSet.insert(location.query)
        if let response = try? await service.fetchWeather(for: location.query) {
            weatherMap[location.query] = response
        }
        loadingSet.remove(location.query)
    }

    func remove(_ location: SavedLocation, context: ModelContext) {
        context.delete(location)
        try? context.save()
        loadAll(from: context)
    }
}
