//
//  WeatherResponse.swift
//  FrostBite
//
//  Created by TaqieAllah on 02/06/2026.
//

import Foundation

struct WeatherResponse: Codable {
    let location: LocationDTO
    let current: CurrentWeatherDTO
    let forecast: ForecastDTO
}

struct LocationDTO: Codable {
    let name: String
    let region: String
    let country: String
    let lat: Double
    let lon: Double
    let localtime: String
}

struct CurrentWeatherDTO: Codable {
    let tempC: Double
    let feelslikeC: Double
    let humidity: Int
    let pressureMb: Double
    let visKm: Double
    let condition: ConditionDTO

    enum CodingKeys: String, CodingKey {
        case tempC = "temp_c"
        case feelslikeC = "feelslike_c"
        case humidity
        case pressureMb = "pressure_mb"
        case visKm = "vis_km"
        case condition
    }
}

struct ForecastDTO: Codable {
    let forecastday: [ForecastDayDTO]
}

struct ForecastDayDTO: Codable, Identifiable {
    var id: String { date }
    let date: String
    let day: DayDTO
    let hour: [HourDTO]
}

struct DayDTO: Codable {
    let maxtempC: Double
    let mintempC: Double
    let condition: ConditionDTO

    enum CodingKeys: String, CodingKey {
        case maxtempC = "maxtemp_c"
        case mintempC = "mintemp_c"
        case condition
    }
}

struct HourDTO: Codable, Identifiable {
    var id: String { time }
    let time: String
    let tempC: Double
    let condition: ConditionDTO

    enum CodingKeys: String, CodingKey {
        case time
        case tempC = "temp_c"
        case condition
    }
}

struct ConditionDTO: Codable {
    let text: String
    let icon: String
}

struct SearchResultDTO: Codable, Identifiable {
    var id: Int
    let name: String
    let region: String
    let country: String
}
