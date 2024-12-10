//
//  testModelView.swift
//  Wweather
//
//  Created by Simon Naud on 10/12/24.
//

import Foundation
import MapKit
import CoreLocation
import Combine

class AddressAutocompleteManager: NSObject, ObservableObject, MKLocalSearchCompleterDelegate {
    @Published var suggestions: [String] = []

    private let searchCompleter: MKLocalSearchCompleter

    override init() {
        self.searchCompleter = MKLocalSearchCompleter()
        super.init()
        self.searchCompleter.delegate = self
        self.searchCompleter.resultTypes = .address
    }

    func updateQuery(_ query: String) {
        searchCompleter.queryFragment = query
    }

    // MKLocalSearchCompleterDelegate Method
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.suggestions = completer.results.map { $0.title }
    }

    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print("Error: \(error.localizedDescription)")
        self.suggestions = []
    }
}

func getCoordinate( addressString : String,
        completionHandler: @escaping(CLLocationCoordinate2D, NSError?) -> Void ) {
    let geocoder = CLGeocoder()
    geocoder.geocodeAddressString(addressString) { (placemarks, error) in
        if error == nil {
            if let placemark = placemarks?[0] {
                let location = placemark.location!
                    
                completionHandler(location.coordinate, nil)
                return
            }
        }
            
        completionHandler(kCLLocationCoordinate2DInvalid, error as NSError?)
    }
}

