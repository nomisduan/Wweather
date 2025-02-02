//
//  WeatherModel.swift
//  Wweather
//
//  Created by Simon Naud on 02/02/2025.
//

import Foundation
import CoreLocation
import WeatherKit

struct WeatherModel {
    let location: LocationModel
    let currentWeather: CurrentWeather
    let hourlyForecast: [HourlyForecast]
    let dailyForecast: [DailyForecast]
    
    struct CurrentWeather {
        let temperature: Double
        let feelsLike: Double       // Température ressentie
        let condition: String
        let humidity: Double
        let windSpeed: Double
       // let precipitation: Precipitation
    }
    
    struct Precipitation {
        let chance: Double          // Probabilité de précipitation (0-1)
        let intensity: Double       // Intensité en mm/h
       // let type: PrecipitationType // Type de précipitation
    }
    
    enum PrecipitationType: String {
        case none = "Aucune"
        case rain = "Pluie"
        case snow = "Neige"
        case sleet = "Neige fondue"
        case hail = "Grêle"
    }
    
    struct HourlyForecast: Identifiable {
        let id = UUID()
        let date: Date
        let temperature: Double
        let feelsLike: Double
        let condition: String
      //  let precipitation: Precipitation
    }
    
    struct DailyForecast: Identifiable {
        let id = UUID()
        let date: Date
        let highTemperature: Double
        let lowTemperature: Double
        let condition: String
       // let precipitation: Precipitation
    }
}
