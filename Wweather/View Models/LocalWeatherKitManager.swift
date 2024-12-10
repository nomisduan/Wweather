//
//  currentWeather.swift
//  Wweather
//
//  Created by Simon Naud on 09/12/24.
//

import Foundation
import WeatherKit

@MainActor class LocalWeatherKitManager: ObservableObject {
    
    @Published var weather: Weather?
    
    func getWeather(latitude: Double, longitude: Double) async {
        do {
            weather = try await Task.detached(priority: .userInitiated) {
                return try await WeatherService.shared.weather(for: .init(latitude: latitude, longitude: longitude))
            }.value
        } catch {
            fatalError("\(error)")
        }
    }
    
    var temp: String {
        if let temperature = weather?.currentWeather.temperature {
            let celsiusValue = temperature.converted(to: .celsius).value
            return "\(Int(celsiusValue))"
        } else {
            return "..."
        }
    }
    
    var symbol: String {
        weather?.currentWeather.symbolName ?? "xmark"
    }
    
    var feelsLike: String {
        if let feelsLikeTemperature = weather?.currentWeather.apparentTemperature {
            let celsiusValue = feelsLikeTemperature.converted(to: .celsius).value
            return "\(Int(celsiusValue))"
        } else {
            return "..."
        }
    }
    
    var humidity: String {
        if let humidityPercentage = weather?.currentWeather.humidity {
            return "\(Int(humidityPercentage * 100))"
        } else {
            return "..."
        }
    }
    
    var windSpeed: String {
        if let windSpeedKph = weather?.currentWeather.wind.speed {
            let kmValue = windSpeedKph.converted(to: .kilometersPerHour).value
            return "\(Int(kmValue))"
        } else {
            return "..."
        }
    }
    
    var windDirection: Double {
        if let windDirectionMeasurement = weather?.currentWeather.wind.direction {
            let windDirectionInDegrees = windDirectionMeasurement.converted(to: .degrees).value
            return windDirectionInDegrees
        } else {
            return 0
        }
    }
    
    
}
