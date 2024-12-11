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
                                                   RemoteCityView(cityName: "Napoli")
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
                        LocalWeatherTileView()
                        RemoteWeatherTileView()
                    }
                    .padding(.bottom)
                    HStack{
                        Image(systemName: "wind")
                        
                            .foregroundStyle(.gray)
                        Text("Wind")
                    
                            .foregroundStyle(.gray)
                    }
                    HStack{
                        LocalWindTileView()
                        RemoteWindTileView()
                    }
                    .padding(.bottom)
                    HStack{
                        Image(systemName: "sun.max")
                        //.font(.caption)
                            .foregroundStyle(.gray)
                        Text("UV Index")
                        //.font(.caption)
                            .foregroundStyle(.gray)
                    }
                    HStack{
                        LocalUVIndexTileView()
                        RemoteUVIndexTileView()
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
