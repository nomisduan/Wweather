//
//  SearchCityView.swift
//  Wweather
//
//  Created by Simon Naud on 10/12/24.
//

import SwiftUI
import CoreLocation

struct SearchCityView: View {
    @StateObject private var autocompleteManager = AddressAutocompleteManager()
    @State private var address: String = ""
    @State private var errorMessage: String?
    
    
    @Binding var selectedCoordinates: CLLocationCoordinate2D? // Binding pour envoyer les coordonnées sélectionnées

    var body: some View {
        VStack(spacing: 16) {
            // Barre de recherche
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.white)
                TextField("Search for a city", text: $address)
                    .textFieldStyle(.plain)
                    .padding(.horizontal)
                    .onChange(of: address) {
                        autocompleteManager.updateQuery(address) // Rechercher les suggestions
                    }
            }
            
            // Liste des suggestions
            if !autocompleteManager.suggestions.isEmpty {
                List(autocompleteManager.suggestions) { suggestion in
                    HStack {
                        Text(suggestion.city)
                            .font(.headline)
                        Spacer()
                        Text(suggestion.country)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .onTapGesture {
                        selectSuggestion(suggestion)
                        fetchCoordinates(for: suggestion.city)
                    }
                }
                .listStyle(.inset)
            }
            
            // Affichage des coordonnées ou erreurs
            if let errorMessage = errorMessage {
                Text("Erreur : \(errorMessage)")
                    .foregroundColor(.red)
            }
        }
        .padding()
    }
    
    private func selectSuggestion(_ suggestion: LocationSuggestion) {
        address = suggestion.city
        autocompleteManager.suggestions = [] // Effacer les suggestions
    }

    private func fetchCoordinates(for address: String) {
        // Réinitialiser les coordonnées pour chaque nouvelle recherche
        self.selectedCoordinates = nil // Réinitialiser les coordonnées de sélection
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { placemarks, error in
            if let error = error {
                self.errorMessage = error.localizedDescription
            } else if let location = placemarks?.first?.location {
                // Mettre à jour les coordonnées via le Binding
                self.selectedCoordinates = location.coordinate
                self.errorMessage = nil
            } else {
                self.errorMessage = "Aucun résultat trouvé."
            }
        }
    }
}
