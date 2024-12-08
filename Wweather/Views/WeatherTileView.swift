//
//  WeatherTileView.swift
//  Wweather
//
//  Created by Simon Naud on 07/12/2024.
//

import SwiftUI

struct WeatherTileView: View {
    let temperature : Int
    let feelsLike : Int
    let rainMm : Int
    let rain12h : Int
    let humidity : Int
    let weatherConditions : String
    
    var body: some View {
        ZStack{
            VStack(alignment: .leading){
// Bloc Temperature & conditions
                HStack{
                    VStack(alignment: .leading){
                        Text("\(temperature)°")
                            .font(.title)
                            .foregroundStyle(.white)
                            .fontWeight(.bold)
                        Text("Feels like \(feelsLike)°")
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }
                    
                    Spacer()
                    
                    Image(systemName: weatherConditions)
                        .foregroundStyle(.white)
                        .font(.largeTitle)
                }
                Spacer()
// Bloc Precipitations
                VStack(alignment: .leading){
                    HStack {
                        Image(systemName: "drop.halffull")
                            .foregroundStyle(.white)
                        
                        Text("\(rainMm)mm")
                            .font(.title2)
                            .foregroundStyle(.white)
                            .fontWeight(.bold)
                    }
                    Text("\(rain12h)mm next 12h")
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
// Bloc Humidity
                Spacer()
                HStack{
                    Image(systemName: "humidity.fill")
                        .foregroundStyle(.white)
                    
                    Text("\(humidity)%")
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
        
    }
}

#Preview {
    WeatherTileView(temperature: 3, feelsLike: 0, rainMm: 3, rain12h: 12, humidity: 74, weatherConditions: "cloud.snow.fill")
}
