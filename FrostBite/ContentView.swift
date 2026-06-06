//
//  ContentView.swift
//  FrostBite
//
//  Created by TaqieAllah on 31/05/2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationStack {
                HomeView()
            }
            .tabItem {
                Label("Weather", systemImage: "cloud.sun.fill")
            }
            
            NavigationStack {
                FavouritesView()
            }
            .tabItem {
                Label("Favourites", systemImage: "star.fill")
            }
        }
    }
}
