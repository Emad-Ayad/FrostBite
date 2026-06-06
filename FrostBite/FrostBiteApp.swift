//
//  FrostBiteApp.swift
//  FrostBite
//
//  Created by TaqieAllah on 31/05/2026.
//

import SwiftUI
import SwiftData

@main
struct FrostBiteApp: App {
    var body: some Scene {
        WindowGroup {
            SplashView()
        }
        .modelContainer(for: SavedLocation.self)
    }
}
