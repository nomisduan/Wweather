//
//  currentWeather.swift
//  Wweather
//
//  Created by Simon Naud on 09/12/24.
//

import Foundation
import WeatherKit

@MainActor class WeatherKitManager: ObservableObject {
    
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
    
    var symbol: String {
        weather?.currentWeather.symbolName ?? "xmark"
    }
    
    var temp: String {
        let temp =
        weather?.currentWeather.temperature
        
        let convert = temp?.converted(to: .celsius).description
        return convert ?? "Loading Weather Data"
        
    }
    
}
