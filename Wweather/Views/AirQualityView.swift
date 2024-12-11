//
//  AirQualityView.swift
//  Wweather
//
//  Created by Simon Naud on 07/12/2024.
//

import SwiftUI



struct UVIndexView: View {
    
   
    
    @StateObject private var locationManager = LocationManager()
       @StateObject private var weatherViewModel = CurrentWeatherKitViewModel()
    
    
    var body: some View {
        
        if locationManager.authorizationStatus == .authorizedWhenInUse {
        ZStack(alignment: .topLeading){
            VStack(alignment: .leading, spacing: 1){
                HStack {
                    Text(String(weatherViewModel.displayUvIndex))
                        .foregroundStyle(.white)
                        .font(.title3)
                    if weatherViewModel.displayUvIndex >= 8 {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundStyle(.yellow)
                    }
                }
                ZStack {
                    RoundedRectangle(cornerRadius: 4)
                        .frame(width: 140, height: 8)
                        .foregroundStyle(
                            LinearGradient(colors: [.blue, .green, .yellow, .red, .purple], startPoint: .leading, endPoint: .trailing)
                        )
                    Circle()
                        .frame(width: 20)
                        .foregroundStyle(.white)
                        .offset(x: CGFloat((120/11) * weatherViewModel.displayUvIndex - 60
                                          ))
                }
            }
        }
            .frame(width: 180, height: 70)
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
    UVIndexView()
}
