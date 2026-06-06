//
//  HomeView.swift
//  FrostBite
//
//  Created by TaqieAllah on 02/06/2026.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var viewModel = HomeViewModel()
    @Binding var selectedCity: String
    @Binding var selectedTab: Int
    @State private var showSearch = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image(ThemeHelper.backgroundImageName)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                Color.black.opacity(ThemeHelper.isMorning ? 0.10 : 0.25)
                    .ignoresSafeArea()
                
                content.padding(12)
            }
            .task {
                if viewModel.weather == nil {
                    await viewModel.loadWeather(for: selectedCity)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showSearch = true
                    } label: {
                        Image(systemName: "magnifyingglass")
                    }
                }
            }.sheet(isPresented: $showSearch) {
                NavigationStack {
                    SearchView { city in
                        selectedCity = city
                        
                        Task {
                            await viewModel.loadWeather(for: city)
                        }
                    }
                }
            }.onChange(of: selectedCity) { _, newCity in
                Task { await viewModel.loadWeather(for: newCity) }
            }
        }
    }
    
    @ViewBuilder
    private var content: some View {
        if viewModel.isLoading {
            ProgressView("Loading...")
                .tint(ThemeHelper.textColor)
                .foregroundColor(ThemeHelper.textColor)
        } else if !viewModel.errorMessage.isEmpty {
            VStack(spacing: 12) {
                Text(viewModel.errorMessage)
                    .foregroundColor(ThemeHelper.textColor)
                    .multilineTextAlignment(.center)
                
                Button("Retry") {
                    Task {
                        await viewModel.loadWeather()
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(.ultraThinMaterial)
                .clipShape(Capsule())
            }
            .padding()
        } else {
            ScrollView {
                VStack(spacing: 24) {
                    topSection
                    middleSection
                    bottomSection
                }
                .padding()
            }
        }
    }
    
    private var topSection: some View {
        VStack(spacing: 8) {
            Text(viewModel.locationName)
                .font(.largeTitle.bold())
                .foregroundColor(ThemeHelper.textColor)
            
            Text(viewModel.currentTemperature)
                .font(.system(size: 64, weight: .light))
                .foregroundColor(ThemeHelper.textColor)
            
            Text(viewModel.conditionText)
                .font(.title3)
                .foregroundColor(ThemeHelper.textColor)
            
            Text("\(viewModel.maxTemperature)   \(viewModel.minTemperature)")
                .font(.headline)
                .foregroundColor(ThemeHelper.textColor)
            
            RemoteImageView(url: viewModel.conditionIconURL)
        }
        .padding(.top, 20)
    }
    
    private var middleSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("3-DAY FORECAST")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(ThemeHelper.textColor.opacity(0.9))
            
            ForEach(Array(viewModel.forecastDays.enumerated()), id: \.element.id) { index, day in
                NavigationLink {
                    DetailsView(day: day)
                } label: {
                    HStack {
                        Text(viewModel.titleForDay(day, index: index))
                            .fontWeight(.bold)
                            .foregroundColor(ThemeHelper.textColor)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        RemoteImageView(url: URL(string: "https:\(day.day.condition.icon)"))
                            .frame(width: 30, height: 30)
                            .frame(maxWidth: .infinity, alignment: .center)
                        
                        Text("\(Int(day.day.mintempC))° - \(Int(day.day.maxtempC))°")
                            .foregroundColor(ThemeHelper.textColor)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    .padding(.vertical, 6)
                }
                
                if index != viewModel.forecastDays.count - 1 {
                    Divider()
                        .background(ThemeHelper.textColor.opacity(0.5))
                }
            }
        }
        .padding()
        .background(ThemeHelper.cardColor)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
    
    private var bottomSection: some View {
        LazyVGrid(columns: [
            GridItem(.flexible()),
            GridItem(.flexible())
        ], spacing: 16) {
            
            metricCard(title: "VISIBILITY", value: viewModel.visibilityText)
            metricCard(title: "HUMIDITY", value: viewModel.humidityText)
            metricCard(title: "FEELS LIKE", value: viewModel.feelsLikeText)
            metricCard(title: "PRESSURE", value: viewModel.pressureText)
        }
    }
    
    private func metricCard(title: String, value: String) -> some View {
        VStack(spacing: 8) {
            Text(title)
                .font(.system(size: 18))
                .foregroundColor(ThemeHelper.textColor)
            
            Text(value)
                .font(.title3.bold())
                .foregroundColor(ThemeHelper.textColor)
        }
        .frame(maxWidth: .infinity, minHeight: 90)
        .padding()
        .background(ThemeHelper.cardColor)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
