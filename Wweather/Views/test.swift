//
//  test.swift
//  Wweather
//
//  Created by Simon Naud on 06/12/24.
//

import SwiftUI
import CoreLocation

struct test: View {
    
    
    @StateObject private var autocompleteManager = AddressAutocompleteManager()
    @State private var address: String = ""
    @State private var selectedSuggestion: String = ""
    @State private var coordinates: CLLocationCoordinate2D?
    @State private var errorMessage: String?
    
    var body: some View {
        VStack {
            TextField("Search for a city", text: $address)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .onChange(of: address) { newValue in
                    autocompleteManager.updateQuery(newValue)
                }
            
            if !autocompleteManager.suggestions.isEmpty {
                List(autocompleteManager.suggestions, id: \.self) { suggestion in
                    Text(suggestion)
                        .onTapGesture {
                            address = suggestion
                            autocompleteManager.suggestions = [] // Clear suggestions
                        }
                }
                .frame(height: 150) // Adjust the height as needed
            }
            
            Button("Obtenir les coordonnées") {
                getCoordinate(addressString: address) { coord, error in
                    if let error = error {
                        self.errorMessage = error.localizedDescription
                        self.coordinates = nil
                    } else {
                        self.coordinates = coord
                        self.errorMessage = nil
                    }
                }
            }
            .padding()
            .buttonStyle(.borderedProminent)
            
            if let coordinates = coordinates {
                Text("Latitude : \(coordinates.latitude)")
                Text("Longitude : \(coordinates.longitude)")
            } else if let errorMessage = errorMessage {
                Text("Erreur : \(errorMessage)")
                    .foregroundColor(.red)
            }
        }
        .padding()
    }
    
    func getCoordinate(addressString: String, completionHandler: @escaping (CLLocationCoordinate2D, NSError?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressString) { (placemarks, error) in
            if error == nil {
                if let placemark = placemarks?.first, let location = placemark.location {
                    completionHandler(location.coordinate, nil)
                    return
                }
            }
            completionHandler(kCLLocationCoordinate2DInvalid, error as NSError?)
        }
        
    }
}

         #Preview {
        test()
}
