//
//  WeatherModelView.swift
//  Wweather
//
//  Created by Simon Naud on 02/02/2025.
//

import SwiftUI
import CoreLocation
import WeatherKit

@MainActor
class WeatherViewModel: ObservableObject {
    // MARK: - Published properties
    @Published var currentLocationWeather: WeatherModel?
    @Published var selectedLocationWeather: WeatherModel?
    @Published var errorMessage: String?
    @Published var isLoading = false
    
    // MARK: - Private properties
    private let weatherService = WeatherService.shared
    private let locationManager = CLLocationManager()
    private let locationDelegate = LocationManagerDelegate()
    private var updateTimer: Timer?
    
    // MARK: - Constants
    private enum UserDefaultsKeys {
        static let selectedLocation = "selectedLocation"
    }
    
    // MARK: - Lifecycle
    init() {
        setupLocationManager()
        setupUpdateTimer()
        //loadSavedLocation()
    }
    
    deinit {
        updateTimer?.invalidate()
    }
    
    // MARK: - Setup Methods
    private func setupLocationManager() {
        locationManager.delegate = locationDelegate
        locationDelegate.onLocationUpdate = { [weak self] location in
            Task {
                await self?.fetchWeatherForCurrentLocation(location: location)
            }
        }
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    private func setupUpdateTimer() {
        updateTimer = Timer.scheduledTimer(withTimeInterval: 900, repeats: true) { [weak self] _ in
            Task {
                await self?.refreshWeatherData()
            }
        }
    }
    
    // MARK: - Weather Fetching
    private func refreshWeatherData() async {
        if let currentLocation = locationManager.location {
            await fetchWeatherForCurrentLocation(location: currentLocation)
        }
        
        if let savedLocation = loadSavedLocation() {
            await fetchWeatherForLocation(savedLocation)
        }
    }
    
    func fetchWeatherForCurrentLocation(location: CLLocation) async {
        do {
            isLoading = true
            let weather = try await weatherService.weather(for: location)
            
            currentLocationWeather = await convertToWeatherModel(
                weather: weather,
                location: LocationModel(
                    name: await getLocationName(for: location),
                    coordinate: location.coordinate,
                    isCurrentLocation: true
                )
            )
        } catch {
            errorMessage = "Erreur lors de la récupération de la météo: \(error.localizedDescription)"
        }
        isLoading = false
    }
    
    func fetchWeatherForLocation(_ location: LocationModel) async {
        do {
            isLoading = true
            let clLocation = CLLocation(
                latitude: location.coordinate.latitude,
                longitude: location.coordinate.longitude
            )
            let weather = try await weatherService.weather(for: clLocation)
            
            selectedLocationWeather = await convertToWeatherModel(
                weather: weather,
                location: location  // On passe le LocationModel original
            )
        } catch {
            errorMessage = "Erreur lors de la récupération de la météo: \(error.localizedDescription)"
        }
        isLoading = false
    }
    
    // MARK: - Location Management
    private func getLocationName(for location: CLLocation) async -> String {
        do {
            let geocoder = CLGeocoder()
            let placemarks = try await geocoder.reverseGeocodeLocation(location)
            if let placemark = placemarks.first {
                return placemark.locality ?? "Localisation inconnue"
            }
        } catch {
            print("Erreur de géocodage: \(error.localizedDescription)")
        }
        return "Localisation inconnue"
    }
    
    // MARK: - Data Persistence
    func saveSelectedLocation(_ location: LocationModel) {
        let locationData = try? JSONEncoder().encode(LocationData(from: location))
        UserDefaults.standard.set(locationData, forKey: UserDefaultsKeys.selectedLocation)
        
        Task {
            await fetchWeatherForLocation(location)
        }
    }
    
    private func loadSavedLocation() -> LocationModel? {
        guard let data = UserDefaults.standard.data(forKey: UserDefaultsKeys.selectedLocation),
              let locationData = try? JSONDecoder().decode(LocationData.self, from: data) else {
            return nil
        }
        
        return LocationModel(
            name: locationData.name,
            coordinate: CLLocationCoordinate2D(
                latitude: locationData.latitude,
                longitude: locationData.longitude
            ),
            isCurrentLocation: false
        )
    }
    
    // MARK: - Data Conversion
    private func convertToWeatherModel(weather: Weather, location: LocationModel) async -> WeatherModel {
        let current = WeatherModel.CurrentWeather(
            temperature: weather.currentWeather.temperature.value,
            feelsLike: weather.currentWeather.apparentTemperature.value,
            condition: weather.currentWeather.condition.description,
            humidity: weather.currentWeather.humidity,
            windSpeed: weather.currentWeather.wind.speed.value//,
            //precipitation: getPrecipitation(from: weather.currentWeather)
        )
        
        let hourly = weather.hourlyForecast.forecast.prefix(24).map { hour in
            WeatherModel.HourlyForecast(
                // id: UUID(),
                date: hour.date,
                temperature: hour.temperature.value,
                feelsLike: hour.apparentTemperature.value,
                condition: hour.condition.description //,
                //precipitation: getPrecipitation(from: hour)
            )
        }
        
        let daily = weather.dailyForecast.forecast.prefix(7).map { day in
            WeatherModel.DailyForecast(
                // id: UUID(),
                date: day.date,
                highTemperature: day.highTemperature.value,
                lowTemperature: day.lowTemperature.value,
                condition: day.condition.description //,
                //precipitation: getPrecipitation(from: day)
            )
        }
        
        return WeatherModel(
            location: location,
            currentWeather: current,
            hourlyForecast: Array(hourly),
            dailyForecast: Array(daily)
        )
    }
    
//    private func getPrecipitation(from weather: any WeatherPrecipitation) -> WeatherModel.Precipitation {
//        let type: WeatherModel.PrecipitationType = {
//            switch weather.precipitation {
//            case .none: return .none
//            case .rain: return .rain
//            case .snow: return .snow
//            case .sleet: return .sleet
//            case .hail: return .hail
//            @unknown default: return .none
//            }
//        }()
//        
//        return WeatherModel.Precipitation(
//            chance: weather.precipitationChance,
//            intensity: weather.precipitationIntensity.value,
//            type: type
//        )
//    }
    
    // MARK: - Helper Types
    private struct LocationData: Codable {
        let name: String
        let latitude: Double
        let longitude: Double
        
        init(from location: LocationModel) {
            self.name = location.name
            self.latitude = location.coordinate.latitude
            self.longitude = location.coordinate.longitude
        }
    }
}

// MARK: - Location Manager Delegate
class LocationManagerDelegate: NSObject, CLLocationManagerDelegate {
    var onLocationUpdate: ((CLLocation) -> Void)?
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        onLocationUpdate?(location)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Erreur de localisation: \(error.localizedDescription)")
    }
}

// MARK: - Public Interface Extensions
extension WeatherViewModel {
    func refreshManually() async {
        await refreshWeatherData()
    }
    
    func clearSavedLocation() {
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.selectedLocation)
        selectedLocationWeather = nil
    }
}
