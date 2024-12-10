//
//  AirQualityView.swift
//  Wweather
//
//  Created by Simon Naud on 07/12/2024.
//

import SwiftUI



struct AirQualityView: View {
    
    @ObservedObject var weatherKitManager = WeatherKitManager()
    @StateObject var locationDataManager = LocationDataManager()
    
    let airQualityLabel : String
    let airQualityCursor : Double
    
    var body: some View {
        
        if locationDataManager.authorizationStatus == .authorizedWhenInUse {
        ZStack(alignment: .topLeading){
            VStack(alignment: .leading, spacing: 1){
                HStack {
                    Text(airQualityLabel)
                        .foregroundStyle(.white)
                        .font(.title3)
                    if airQualityCursor >= 25.0 {
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
                        .offset(x: CGFloat(airQualityCursor))
                }
            }
        }
            .frame(width: 180, height: 70)
            .background(Color.deepdark)
            .cornerRadius(25)
            
            .task {
                await weatherKitManager.getWeather(latitude: locationDataManager.latitude, longitude: locationDataManager.longitude)
            }
    } else {
        Text("Error Loading Location")
    }
}
}

#Preview {
    AirQualityView(airQualityLabel: "Fair", airQualityCursor: 51.0)
}
