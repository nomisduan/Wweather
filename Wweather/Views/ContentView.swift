//
//  ContentView.swift
//  Wweather
//
//  Created by Simon Naud on 06/12/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isSheetPresented = false
    
    var body: some View {
        ZStack(alignment: .top){
            Color.backgroundDark.edgesIgnoringSafeArea(.all)

            LinearGradient(gradient: Gradient(colors: [Color.backgroundLight, Color.clear]), startPoint: .top, endPoint: .bottom)
                        .frame(height: 200)
                        .edgesIgnoringSafeArea(.all)
            
            VStack {
                VStack(alignment: .leading, spacing: 1)
                {
                    Spacer()
                    HStack{
                        LocalCityView()
                                               Button(action: {
                                                   isSheetPresented = true
                                               }) {
                                                   CityView(cityName: "Napoli")
                                               }
                                               .buttonStyle(PlainButtonStyle())
                                           }
                                           .padding(.bottom, 10)
                    
                    .padding(.bottom, 10)
                    HStack{
                        Image(systemName: "thermometer.medium")
           
                            .foregroundStyle(.gray)
                        Text("Weather conditions")
   
                            .foregroundStyle(.gray)
                    }
                    HStack{
                        WeatherTileView(temperature: 3, feelsLike: 0, rainMm: 3, rain12h: 12, humidity: 74, weatherConditions: "cloud.snow.fill")
                        WeatherTileView(temperature: -3, feelsLike: -10, rainMm: 0, rain12h: 0, humidity: 40, weatherConditions: "sun.max.fill")
                    }
                    .padding(.bottom)
                    HStack{
                        Image(systemName: "wind")
                        
                            .foregroundStyle(.gray)
                        Text("Wind")
                    
                            .foregroundStyle(.gray)
                    }
                    HStack{
                        WindTileView(windSpeed: 20, windDirection: 180.0)
                        WindTileView(windSpeed: 34, windDirection: 90.0)
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
                        AirQualityView(airQualityLabel: "Poor", airQualityCursor: 30.0)
                        AirQualityView(airQualityLabel: "Fair", airQualityCursor: -30.0)
                    }
                    
                }
                TimeTravelBarView(topCity: "Na", bottomCity: "Na")
            }
        .padding()
        }
        .sheet(isPresented: $isSheetPresented) {
            SearchCityView(cityName: "Napoli")
        }
    }
}

#Preview {
    ContentView()
}
