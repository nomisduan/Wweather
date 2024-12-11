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
                Text(city)
                    .font(.system(.largeTitle, design: .serif))
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                
                Text(Date.now, format: .dateTime.hour().minute())
                    .font(.largeTitle)
                    .fontWeight(.light)
                    .foregroundStyle(.white)
            }
            .frame(width: 180)
        }
        else {
            Text("Select")
        }
    }
}


