//
//  RemoteWeatherTileView.swift
//  Wweather
//
//  Created by Simon Naud on 11/12/24.
//

import SwiftUI

struct RemoteWeatherTileView: View {
        @StateObject private var locationManager = LocationManager()
       @StateObject private var weatherViewModel = CurrentWeatherKitViewModel()
    
    var body: some View {
        
        if locationManager.authorizationStatus == .authorizedWhenInUse {
            ZStack{
                VStack(alignment: .leading){
    // Bloc Temperature & conditions
                    HStack{
                        VStack(alignment: .leading){
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
    // Bloc Precipitations
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
    // Bloc Humidity
                    Spacer()
                    HStack{
                        Image(systemName: "humidity.fill")
                            .foregroundStyle(.white)
                        
                        Text("\(weatherViewModel.displayHumidity)%")
                            .font(.title2)
                            .foregroundStyle(.white)
                            .fontWeight(.bold)
                    }
                }
                .padding()
            }
            .frame(width: 180, height: 195)
            .background(Color.deepdark)
            .cornerRadius(25)
            
                .task {
                    if locationManager.latitude != 0.0, locationManager.longitude != 0.0 {
                                          await weatherViewModel.fetchWeather(latitude: locationManager.latitude, longitude: locationManager.longitude)
                                      }
                                  }
                              } else  {
            Text("Error Loading Location")
        }
    }
}
        
        
    

#Preview {
    RemoteWeatherTileView()
}
