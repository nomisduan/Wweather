//
//  LocationManager.swift
//  Wweather
//
//  Created by Simon Naud on 10/12/24.
//

//
import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    private var locationManager = CLLocationManager()
    @Published var authorizationStatus: CLAuthorizationStatus?
    @Published var currentCity: String = "Loading..."
    
    var latitude: Double {
        locationManager.location?.coordinate.latitude ?? 0.0
    }
    
    var longitude: Double {
        locationManager.location?.coordinate.longitude ?? 0.0
    }
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    // Demande de permission de localisation et démarrage des mises à jour
    func requestLocationPermission() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    // Recherche inverse pour obtenir le nom de la ville
    func lookUpCurrentLocation(completionHandler: @escaping (CLPlacemark?) -> Void) {
        if let lastLocation = locationManager.location {
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(lastLocation) { (placemarks, error) in
                if error == nil {
                    let firstLocation = placemarks?.first
                    completionHandler(firstLocation)
                } else {
                    completionHandler(nil)
                }
            }
        } else {
            completionHandler(nil)
        }
    }

    // CLLocationManagerDelegate - Gère les mises à jour de la localisation
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Met à jour la ville basée sur la nouvelle localisation
        lookUpCurrentLocation { placemark in
            if let city = placemark?.locality {
                self.currentCity = city
            } else {
                self.currentCity = "Unknown"
            }
        }
    }

    // CLLocationManagerDelegate - Gère les erreurs de localisation
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: \(error.localizedDescription)")
    }

    // CLLocationManagerDelegate - Gère les changements d'autorisation
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:  // Les services de localisation sont disponibles.
            authorizationStatus = .authorizedWhenInUse
            locationManager.requestLocation()
        case .restricted:  // Les services de localisation sont restreints.
            authorizationStatus = .restricted
        case .denied:  // Les services de localisation sont refusés.
            authorizationStatus = .denied
        case .notDetermined: // L'autorisation de localisation n'est pas encore déterminée.
            authorizationStatus = .notDetermined
            manager.requestWhenInUseAuthorization()
        default:
            break
        }
    }
}
