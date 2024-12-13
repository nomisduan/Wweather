//
//  LocalCityView.swift
//  Wweather
//
//  Created by Simon Naud on 10/12/24.
//

import SwiftUI

struct LocalCityView: View {
    @StateObject private var locationManager = LocationManager()
       @State private var cityName: String = "..."

       var body: some View {
           VStack {
               HStack(spacing: 0) {
                   Image(systemName: "location")
                       .foregroundStyle(.white)
                       .font(.caption)
                       .foregroundStyle(.white)
                   Text("MY LOCATION")
                       .font(.caption)
                       .foregroundStyle(.white)
               }
               Text(cityName)
                   .frame(height: 20)
                   .font(.system(.title, design: .serif))
                   .fontWeight(.semibold)
                   .foregroundStyle(.white)
                 

               Text(Date.now, format: .dateTime.hour().minute())
                   .font(.largeTitle)
                   .fontWeight(.light)
                   .foregroundStyle(.white)
           }
           .frame(width: 180)
           .onAppear {
               locationManager.requestLocationPermission()
               locationManager.lookUpCurrentLocation { placemark in
                   if let city = placemark?.locality {
                       cityName = city
                   } else {
                       cityName = "Unknown"
                   }
               }
           }
       }
   }


#Preview {
    ContentView()
}
