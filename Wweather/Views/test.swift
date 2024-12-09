//
//  test.swift
//  Wweather
//
//  Created by Simon Naud on 06/12/24.
//

import SwiftUI
import CoreLocation

struct test: View {
    @ObservedObject var weatherKitManager = WeatherKitManager()
    @StateObject var locationDataManager = LocationDataManager()
    
    var body: some View {
        if locationDataManager.authorizationStatus == .authorizedWhenInUse {
            Label(weatherKitManager.temp, systemImage: weatherKitManager.symbol)
                .task {
                    await weatherKitManager.getWeather(latitude: locationDataManager.latitude, longitude: locationDataManager.longitude)
                }
        } else {
            Text("Error Loading Location")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
