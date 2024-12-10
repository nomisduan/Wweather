//
//  WindTileView.swift
//  Wweather
//
//  Created by Simon Naud on 07/12/2024.
//

import SwiftUI

struct WindTileView: View {
    
    @ObservedObject var localWeatherKitManager = LocalWeatherKitManager()
    @StateObject var locationManager = LocationManager()
    
    let windSpeed : Int
    let windDirection : Double
    
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
                .rotationEffect(Angle(degrees: localWeatherKitManager.windDirection))
            Circle()
                .foregroundStyle(Color.deepdark)
                .frame(width: 60, height: 60)
            Circle()
                .foregroundStyle(.white)
                .frame(width: 55, height: 55)
            VStack(spacing: -3){
                Text(String(localWeatherKitManager.windSpeed))
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
                await localWeatherKitManager.getWeather(latitude: locationManager.latitude, longitude: locationManager.longitude)
            }
    } else {
        Text("Error Loading Location")
    }
}
}
    


#Preview {
    WindTileView(windSpeed: 10, windDirection: 24.0)
}
