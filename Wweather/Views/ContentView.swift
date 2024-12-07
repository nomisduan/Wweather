//
//  ContentView.swift
//  Wweather
//
//  Created by Simon Naud on 06/12/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack(alignment: .top){
            Color.backgroundDark.edgesIgnoringSafeArea(.all)

            LinearGradient(gradient: Gradient(colors: [Color.backgroundLight, Color.clear]), startPoint: .top, endPoint: .bottom)
                        .frame(height: 200)
                        .edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading, spacing: 1) {
                HStack{
                    CityView()
                    CityView()
                }
                .padding(.bottom, 10)
                HStack{
                    Image(systemName: "thermometer.medium")
                        //.font(.caption)
                        .foregroundStyle(.gray)
                    Text("Weather conditions")
                        //.font(.caption)
                        .foregroundStyle(.gray)
                }
                HStack{
                    WeatherTileView()
                    WeatherTileView()
                }
                .padding(.bottom)
                HStack{
                    Image(systemName: "wind")
                        //.font(.caption)
                        .foregroundStyle(.gray)
                    Text("Wind")
                        //.font(.caption)
                        .foregroundStyle(.gray)
                }
                HStack{
                    WindTileView()
                    WindTileView()
                }
                .padding(.bottom)
                HStack{
                    Image(systemName: "aqi.medium")
                        //.font(.caption)
                        .foregroundStyle(.gray)
                    Text("Air quality")
                        //.font(.caption)
                        .foregroundStyle(.gray)
                }
                HStack{
                    AirQualityView()
                    AirQualityView()
                }
            }
            .padding()
        }
        
    }
}

#Preview {
    ContentView()
}
