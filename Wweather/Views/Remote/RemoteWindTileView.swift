//
//  RemoteWindTileView.swift
//  Wweather
//
//  Created by Simon Naud on 11/12/24.
//

import SwiftUI

struct RemoteWindTileView: View {
    
    @StateObject private var locationManager = LocationManager()
    @StateObject private var weatherViewModel = CurrentWeatherKitViewModel()
    
    var body: some View {
        
        if locationManager.authorizationStatus == .authorizedWhenInUse {
        ZStack{

            Circle()
                .stroke(style: StrokeStyle(lineWidth: 8, dash: [1, 9]))
                .foregroundStyle(.gray)
                .frame(width: 100, height: 100)
            VStack {
                Text("N")
                    .foregroundStyle(.red)
                    .font(.subheadline)
                    .fontWeight(.light)
                    .frame(width: 15.0)
                    .background(.deepdark)
                  
                Spacer()
                Text("S")
                    .foregroundStyle(.white)
                    .font(.subheadline)
                    .fontWeight(.light)
                    .background(.deepdark)
                    
            }
            .frame(height: 115)
            HStack {
                Text("E")
                    .foregroundStyle(.white)
                    .font(.subheadline)
                    .fontWeight(.light)
                    .frame(width: 15)
                    .background(.deepdark)
                  
                Spacer()
                Text("W")
                    .foregroundStyle(.white)
                    .font(.subheadline)
                    .fontWeight(.light)
                    .background(.deepdark)
                    
            }
            .frame(width: 115)
           
            Image("arrowWind")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.white)
                .frame(height: 85)
                .rotationEffect(Angle(degrees: weatherViewModel.displayWindDirection))
            Circle()
                .foregroundStyle(Color.deepdark)
                .frame(width: 60, height: 60)
            Circle()
                .foregroundStyle(.white)
                .frame(width: 55, height: 55)
            VStack(spacing: -3){
                Text(String(weatherViewModel.displayWindSpeed))
                    .foregroundStyle(.gray)
                    .font(.title3)
                    .fontWeight(.semibold)
                Text("km/h")
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            
            
                           
        }
            .frame(width: 180, height: 130)
            .background(Color.deepdark)
            .cornerRadius(25)

            .task {
                if locationManager.latitude != 0.0, locationManager.longitude != 0.0 {
                                      await weatherViewModel.fetchWeather(latitude: locationManager.latitude, longitude: locationManager.longitude)
                                  }
                              }
                          } else {
        Text("Error Loading Location")
    }
}
}
    


#Preview {
    RemoteWindTileView()
}
