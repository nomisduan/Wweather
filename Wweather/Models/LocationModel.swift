//
//  LocationModel.swift
//  Wweather
//
//  Created by Simon Naud on 02/02/2025.
//

import Foundation
import CoreLocation

struct LocationModel: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
    let isCurrentLocation: Bool
    
    static func == (lhs: LocationModel, rhs: LocationModel) -> Bool {
        lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.coordinate.latitude == rhs.coordinate.latitude &&
        lhs.coordinate.longitude == rhs.coordinate.longitude
    }
}
