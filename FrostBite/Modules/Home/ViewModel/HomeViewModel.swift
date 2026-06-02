//
//  HomeViewModel.swift
//  FrostBite
//
//  Created by TaqieAllah on 02/06/2026.
//

import Foundation
import Combine

@MainActor
final class HomeViewModel: ObservableObject {
    
    @Published var weather: WeatherResponse?
    @Published var isLoading = false
    @Published var errorMessage = ""
    
    private let service = WeatherService()
    
    func loadWeather(for city: String = "Cairo") async {
        isLoading = true
        errorMessage = ""
        
        do {
            weather = try await service.fetchWeather(for: city)
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func titleForDay(at index: Int) -> String {
        switch index {
        case 0: return "Today"
        case 1: return "Tomorrow"
        case 2: return "After Tomorrow"
        default: return ""
        }
    }
}



extension HomeViewModel {
    
    var locationName: String {
        weather?.location.name ?? ""
    }
    
    var currentTemperature: String {
        guard let temp = weather?.current.tempC else { return "--" }
        return "\(Int(temp))°"
    }
    
    var conditionText: String {
        weather?.current.condition.text ?? ""
    }
    
    var maxTemperature: String {
        guard let temp = weather?.forecast.forecastday.first?.day.maxtempC else { return "--" }
        return "H:\(Int(temp))°"
    }
    
    var minTemperature: String {
        guard let temp = weather?.forecast.forecastday.first?.day.mintempC else { return "--" }
        return "L:\(Int(temp))°"
    }
    
    var conditionIconURL: URL? {
        guard let icon = weather?.current.condition.icon else { return nil }
        return URL(string: "https:\(icon)")
    }
    
    var forecastDays: [ForecastDayDTO] {
        weather?.forecast.forecastday ?? []
    }
    
    var visibilityText: String {
        guard let value = weather?.current.visKm else { return "--" }
        return "\(Int(value)) km"
    }
    
    var humidityText: String {
        guard let value = weather?.current.humidity else { return "--" }
        return "\(value)%"
    }
    
    var feelsLikeText: String {
        guard let value = weather?.current.feelslikeC else { return "--" }
        return "\(Int(value))°"
    }
    
    var pressureText: String {
        guard let value = weather?.current.pressureMb else { return "--" }
        return "\(Int(value)) mb"
    }
}

