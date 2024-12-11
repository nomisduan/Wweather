//
//  SearchBarManager.swift
//  Wweather
//
//  Created by Simon Naud on 11/12/24.
//

import MapKit
import Combine

struct LocationSuggestion: Identifiable {
    let id = UUID()
    let city: String
    let country: String
}

class AddressAutocompleteManager: ObservableObject {
    @Published var suggestions: [LocationSuggestion] = []
    private var searchCancellable: AnyCancellable?
    
    func updateQuery(_ query: String) {
        guard !query.isEmpty else {
            suggestions = []
            return
        }
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.resultTypes = .address
        
        let search = MKLocalSearch(request: request)
        
        search.start { [weak self] response, error in
            guard let response = response, error == nil else {
                self?.suggestions = []
                return
            }
            
            // Extraire les villes et les pays des résultats
            self?.suggestions = response.mapItems.compactMap { item in
                guard let city = item.placemark.locality,
                      let country = item.placemark.country else {
                    return nil
                }
                return LocationSuggestion(city: city, country: country)
            }
        }
    }
}
