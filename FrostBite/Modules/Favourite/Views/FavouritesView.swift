//
//  FavouritesView.swift
//  FrostBite
//
//  Created by TaqieAllah on 06/06/2026.
//

import SwiftUI
import SwiftData

struct FavouritesView: View {
    
    @Environment(\.modelContext) private var context
    @StateObject private var viewModel = FavouritesViewModel()
    
    @Binding var selectedCity: String
    @Binding var selectedTab: Int
    
    @State private var locationToDelete: SavedLocation?
    
    var body: some View {
        ZStack {
            Image(ThemeHelper.backgroundImageName)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            Color.black.opacity(ThemeHelper.isMorning ? 0.10 : 0.25)
                .ignoresSafeArea()
            
            Group {
                if viewModel.favourites.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "star.slash")
                            .font(.system(size: 48))
                            .foregroundColor(ThemeHelper.textColor.opacity(0.6))
                        Text("No favourites yet")
                            .font(.title3)
                            .foregroundColor(ThemeHelper.textColor.opacity(0.8))
                        Text("Star a city from the search screen to save it here.")
                            .font(.caption)
                            .multilineTextAlignment(.center)
                            .foregroundColor(ThemeHelper.textColor.opacity(0.6))
                            .padding(.horizontal)
                    }
                } else {
                    List {
                        ForEach(viewModel.favourites) { location in
                            favouriteCard(for: location)
                                .onTapGesture {
                                    selectedCity = location.name
                                    selectedTab = 0
                                }
                                .task { await viewModel.loadWeather(for: location) }
                                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                    Button() {
                                        locationToDelete = location
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }.tint(.red)
                                }
                                .listRowBackground(Color.clear)
                                .listRowSeparator(.hidden)
                                .listRowInsets(EdgeInsets(top: 6, leading: 16, bottom: 6, trailing: 16))
                        }
                    }
                    .padding(.top, 48)
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                    .alert("Remove Favourite", isPresented: .init(
                        get: { locationToDelete != nil },
                        set: { if !$0 { locationToDelete = nil } }
                    )) {
                        Button("Delete", role: .destructive) {
                            if let loc = locationToDelete {
                                viewModel.remove(loc, context: context)
                                locationToDelete = nil
                            }
                        }
                        Button("Cancel", role: .cancel) {
                            locationToDelete = nil
                        }
                    } message: {
                        if let loc = locationToDelete {
                            Text("Are you sure you want to remove \(loc.name) from favourites?")
                        }
                    }
                }
            }
        }
        .navigationTitle("Favourites")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear { viewModel.loadAll(from: context) }
    }
    
    @ViewBuilder
    private func favouriteCard(for location: SavedLocation) -> some View {
        let weather = viewModel.weatherMap[location.query]
        let isLoading = viewModel.loadingSet.contains(location.query)
        
        HStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 4) {
                Text(location.name)
                    .font(.headline)
                    .foregroundColor(ThemeHelper.textColor)
                
                Text("\(location.region), \(location.country)")
                    .font(.caption)
                    .foregroundColor(ThemeHelper.textColor.opacity(0.7))
                
                if let condition = weather?.current.condition.text {
                    Text(condition)
                        .font(.caption2)
                        .foregroundColor(ThemeHelper.textColor.opacity(0.7))
                }
            }
            
            Spacer()
            
            if isLoading {
                ProgressView()
                    .tint(ThemeHelper.textColor)
            } else if let temp = weather?.current.tempC {
                VStack(spacing: 4) {
                    if let icon = weather?.current.condition.icon {
                        RemoteImageView(url: URL(string: "https:\(icon)"))
                            .frame(width: 36, height: 36)
                    }
                    Text("\(Int(temp))°")
                        .font(.title2.bold())
                        .foregroundColor(ThemeHelper.textColor)
                }
            }
        }
        .padding()
        .background(ThemeHelper.cardColor)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
