//
//  RemoteUVIndexTileView.swift
//  Wweather
//
//  Created by Simon Naud on 11/12/24.
//

import SwiftUI
import CoreLocation

struct RemoteUVIndexTileView: View {
    @StateObject private var locationManager = LocationManager()
    @StateObject private var weatherViewModel = CurrentWeatherKitViewModel()
   
    @Binding var coordinates: CLLocationCoordinate2D?
    
    var body: some View {
        
        if let coordinates = coordinates {
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
                    ZStack {
                        
                        Circle()
                            .frame(width: 14)
                            .foregroundStyle(.deepdark)
                            .offset(x: CGFloat((120/11) * weatherViewModel.displayUvIndex - 60
                                              ))
                    Circle()
                        .frame(width: 8)
                        .foregroundStyle(.white)
                        .offset(x: CGFloat((120/11) * weatherViewModel.displayUvIndex - 60
                                          ))
                    }
                }
            }
        }
            .frame(width: 180, height: 70)
            .background(Color.deepdark)
            .cornerRadius(25)
            
            .task {
                // Fetch weather using the selected coordinates
                await weatherViewModel.fetchWeather(latitude: coordinates.latitude, longitude: coordinates.longitude)
            }
        } else {
           
        }
    }
}


#Preview {
    RemoteUVIndexTileView(coordinates: .constant(nil))
}
