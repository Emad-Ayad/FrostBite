//
//  WeatherService.swift
//  FrostBite
//
//  Created by TaqieAllah on 02/06/2026.
//

import Foundation
import Alamofire

final class WeatherService {
    
    private let apiKey = "440bdeb908944ac08c4204818242011"
    private let baseURL = "https://api.weatherapi.com/v1/forecast.json"
    
    func fetchWeather(for query: String) async throws -> WeatherResponse {
        let parameters: Parameters = [
            "key": apiKey,
            "q": query,
            "days": 3,
            "aqi": "yes",
            "alerts": "no"
        ]
        
        let data = try await AF.request(baseURL, method: .get, parameters: parameters)
            .validate()
            .serializingData()
            .value
        
        return try JSONDecoder().decode(WeatherResponse.self, from: data)
    }
    
    func searchCities(for query: String) async throws -> [SearchResultDTO] {
        let parameters: Parameters = [
            "key": apiKey,
            "q": query
        ]

        let data = try await AF.request("https://api.weatherapi.com/v1/search.json",
                                         method: .get,
                                         parameters: parameters)
            .validate()
            .serializingData()
            .value

        return try JSONDecoder().decode([SearchResultDTO].self, from: data)
    }
    
}
