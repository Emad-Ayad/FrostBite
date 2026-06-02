//
//  SavedLocation.swift
//  FrostBite
//
//  Created by TaqieAllah on 02/06/2026.
//

import Foundation

struct SavedLocation: Codable, Identifiable, Hashable {
    let id: UUID
    let name: String
    let query: String

    init(id: UUID = UUID(), name: String, query: String) {
        self.id = id
        self.name = name
        self.query = query
    }
}
