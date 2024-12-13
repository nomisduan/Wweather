//
//  ContentView.swift
//  Wweather
//
//  Created by Simon Naud on 06/12/24.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    
    @State private var isSheetPresented = false
    @State private var selectedCoordinates: CLLocationCoordinate2D?
    @State private var selectedCity: String?
    
    var body: some View {
        ZStack(alignment: .top){
            Color.backgroundDark.edgesIgnoringSafeArea(.all)
            
            LinearGradient(gradient: Gradient(colors: [Color.backgroundLight, Color.clear]), startPoint: .top, endPoint: .bottom)
                .frame(height: 200)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                HStack {
                    VStack(alignment: .leading, spacing: 1)
                    {
                        
                        HStack{
                            LocalCityView()
                            
                        }
                        .padding(.bottom, 10)
                        
                        .padding(.bottom, 10)
                        HStack{
                            Image(systemName: "thermometer.medium")
                            
                                .foregroundStyle(.gray)
                            Text("Weather conditions")
                            
                                .foregroundStyle(.gray)
                        }
                        .frame(height:25)
                        HStack{
                            LocalWeatherTileView()
                        }
                        .padding(.bottom)
                        HStack{
                            Image(systemName: "wind")
                            
                                .foregroundStyle(.gray)
                            Text("Wind")
                            
                                .foregroundStyle(.gray)
                        }
                        .frame(height:25)
                        
                        HStack{
                            LocalWindTileView()
                            
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
                        .frame(height:25)
                        
                        HStack{
                            LocalUVIndexTileView()
                            
                        }
                        
                    }
                    
                    Spacer()
                    
                    
                    
                    VStack(alignment: .leading, spacing: 1)
                    {
                        HStack{
                            
                            Button(action: {
                                isSheetPresented = true
                            }) {
                                RemoteCityView(city: $selectedCity)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        .padding(.bottom, 10)
                        
                        .padding(.bottom, 10)
                        
                        HStack{
                            
                        }  .frame(height:25)
                        HStack{
                            RemoteWeatherTileView(coordinates: $selectedCoordinates)                    }
                        .padding(.bottom)
                        HStack{
                            
                        } .frame(height:25)
                        
                        HStack{
                            RemoteWindTileView(coordinates: $selectedCoordinates)
                        }
                        .padding(.bottom)
                        HStack{
                            
                        }
                        .frame(height:25)
                        
                        HStack{
                            RemoteUVIndexTileView(coordinates: $selectedCoordinates)
                        }
                        
                    }
                    
                    
                    
                }
                
                .padding(.horizontal, 10)
                Spacer()
                TimeTravelBarView(topCity: "Na", bottomCity: "Na")
                Spacer()
                
            }
        }
        .sheet(isPresented: $isSheetPresented) {
            SearchCityView(selectedCity: $selectedCity, selectedCoordinates: $selectedCoordinates)
        }
    }
}


#Preview {
    ContentView()
}
