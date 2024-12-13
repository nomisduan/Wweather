//
//  CityView.swift
//  Wweather
//
//  Created by Simon Naud on 07/12/2024.
//

import SwiftUI

struct RemoteCityView: View {
    
   
    @Binding var city: String?
    
    var body: some View {
        if let city = city {
            VStack{
                VStack(spacing: 0) {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(.white)
                            .font(.caption)
                            .foregroundStyle(.white)
                        Text("MY LOCATION")
                            .font(.caption)
                            .foregroundStyle(.white)
                    }
                    Text(city)
                        .frame(height: 20)
                        .font(.system(.title, design: .serif))
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                    
                }
                
                Text(Date.now, format: .dateTime.hour().minute())
                    .font(.largeTitle)
                    .fontWeight(.light)
                    .foregroundStyle(.white)
            }
            .frame(width: 180)
        }
        else {
            ZStack{
        }
            .frame(width: 180, height: 500)
            .background(Color.deepdark)
            .cornerRadius(25)
           
        }
    }
}
#Preview {
    TestView()
}

