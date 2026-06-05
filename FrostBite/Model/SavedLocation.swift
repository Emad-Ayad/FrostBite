//
//  SavedLocation.swift
//  FrostBite
//
//  Created by TaqieAllah on 02/06/2026.
//

import Foundation
import SwiftData

@Model
final class SavedLocation {
    @Attribute(.unique) var query: String
    var name: String
    var region: String
    var country: String
    var lat: Double
    var lon: Double
    var isFavorite: Bool
    
    init(
        query: String,
        name: String,
        region: String,
        country: String,
        lat: Double,
        lon: Double,
        isFavorite: Bool = false
    ) {
        self.query = query
        self.name = name
        self.region = region
        self.country = country
        self.lat = lat
        self.lon = lon
        self.isFavorite = isFavorite
    }
}
