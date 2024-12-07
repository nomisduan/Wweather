//
//  WeatherTileView.swift
//  Wweather
//
//  Created by Simon Naud on 07/12/2024.
//

import SwiftUI

struct WeatherTileView: View {
    var body: some View {
        ZStack{
            VStack(alignment: .leading){
// Bloc Temperature & conditions
                HStack{
                    VStack(alignment: .leading){
                        Text("3°")
                            .font(.title)
                            .foregroundStyle(.white)
                            .fontWeight(.bold)
                        Text("Feels like 0°")
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "cloud.snow.fill")
                        .foregroundStyle(.white)
                        .font(.largeTitle)
                }
                Spacer()
// Bloc Precipitations
                VStack(alignment: .leading){
                    HStack {
                        Image(systemName: "drop.halffull")
                            .foregroundStyle(.white)
                        
                        Text("2mm")
                            .font(.title2)
                            .foregroundStyle(.white)
                            .fontWeight(.bold)
                    }
                    Text("12mm next 12h")
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
// Bloc Humidity
                Spacer()
                HStack{
                    Image(systemName: "humidity.fill")
                        .foregroundStyle(.white)
                    
                    Text("77%")
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
    WeatherTileView()
}
