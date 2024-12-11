//
//  currentWeather.swift
//  Wweather
//
//  Created by Simon Naud on 09/12/24.
//

import Foundation
import WeatherKit


@MainActor
class CurrentWeatherKitViewModel: ObservableObject {
    @Published private(set) var currentWeatherModel: CurrentWeatherModel?
    
    func fetchWeather(latitude: Double, longitude: Double) async {
        do {
            let weather = try await WeatherService.shared.weather(for: .init(latitude: latitude, longitude: longitude))
            
            
            currentWeatherModel = CurrentWeatherModel(
                temperature: "\(Int(weather.currentWeather.temperature.converted(to: .celsius).value))",
                feelsLikeTemperature: "\(Int(weather.currentWeather.apparentTemperature.converted(to: .celsius).value))",
                humidity: "\(Int(weather.currentWeather.humidity * 100))",
                windSpeed: "\(Int(weather.currentWeather.wind.speed.converted(to: .kilometersPerHour).value))",
                windDirection: weather.currentWeather.wind.direction.converted(to: .degrees).value,
                symbolName: weather.currentWeather.symbolName,
                uvIndex: weather.currentWeather.uvIndex.value
            )
        } catch {
            print("Failed to fetch weather: \(error)")
        }
    }
    
    
    var displayTemperature: String {
        currentWeatherModel?.temperature ?? "..."
    }
    
    var displayFeelsLike: String {
        currentWeatherModel?.feelsLikeTemperature ?? "..."
    }
    
    var displayHumidity: String {
        currentWeatherModel?.humidity ?? "..."
    }
    
    var displaySymbolName: String {
        currentWeatherModel?.symbolName ?? "xmark"
    }
    
    var displayWindSpeed: String {
        currentWeatherModel?.windSpeed ?? "..."
    }
    
    var displayWindDirection: Double {
        currentWeatherModel?.windDirection ?? 0.0
        
    }
    
    var displayUvIndex : Int {
        currentWeatherModel?.uvIndex ?? 0
    }
}

