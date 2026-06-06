//
//  ContentView.swift
//  FrostBite
//
//  Created by TaqieAllah on 31/05/2026.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedCity = "Cairo"
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack {
                HomeView(selectedCity: $selectedCity, selectedTab: $selectedTab)
            }
            .tabItem {
                Label("Weather", systemImage: "cloud.sun.fill")
            }
            .tag(0)

            
            NavigationStack {
                FavouritesView(selectedCity: $selectedCity, selectedTab: $selectedTab)
            }
            .tabItem {
                Label("Favourites", systemImage: "star.fill")
            }
            .tag(1)

        }
    }
}
