//
//  RemoteWeatherTileView.swift
//  Wweather
//
//  Created by Simon Naud on 11/12/24.
//

import SwiftUI
import CoreLocation

struct RemoteWeatherTileView: View {
    @StateObject private var locationManager = LocationManager()
    @StateObject private var weatherViewModel = CurrentWeatherKitViewModel()
    
    @Binding var coordinates: CLLocationCoordinate2D? // Binding pour accepter les coordonnées

    var body: some View {
        VStack {
            if let coordinates = coordinates {
                ZStack {
                    VStack(alignment: .leading) {
                        // Bloc Temperature & conditions
                        HStack {
                            VStack(alignment: .leading) {
                                Text("\(weatherViewModel.displayTemperature)°")
                                    .font(.title)
                                    .foregroundStyle(.white)
                                    .fontWeight(.bold)
                                Text("Feels like \(weatherViewModel.displayFeelsLike)°")
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                            }
                            
                            Spacer()
                            
                            Image(systemName: weatherViewModel.displaySymbolName)
                                .foregroundStyle(.white)
                                .font(.largeTitle)
                        }
                        Spacer()
                        VStack(alignment: .leading){
                            HStack {
                                Image(systemName: "drop.halffull")
                                    .foregroundStyle(.white)
                                
                                Text("XXmm")
                                    .font(.title2)
                                    .foregroundStyle(.white)
                                    .fontWeight(.bold)
                            }
                            Text("XXmm next 12h")
                                .font(.caption)
                                .foregroundStyle(.gray)
                        }
                        Spacer()
                        // Bloc Humidity
                        VStack(alignment: .leading) {
                            HStack {
                                Image(systemName: "humidity.fill")
                                    .foregroundStyle(.white)
                                
                                Text("\(weatherViewModel.displayHumidity)%")
                                    .font(.title2)
                                    .foregroundStyle(.white)
                                    .fontWeight(.bold)
                            }
                        }
                    }
                    .padding()
                }
                .frame(width: 180, height: 195)
                .background(Color.deepdark)
                .cornerRadius(25)
                .task {
                    // Fetch weather using the selected coordinates
                    await weatherViewModel.fetchWeather(latitude: coordinates.latitude, longitude: coordinates.longitude)
                }
            } else {
               
            }
        }
    }
}

#Preview {
    RemoteWeatherTileView(coordinates: .constant(nil))
}
