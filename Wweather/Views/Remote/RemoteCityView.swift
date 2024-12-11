//
//  CityView.swift
//  Wweather
//
//  Created by Simon Naud on 07/12/2024.
//

import SwiftUI

struct RemoteCityView: View {
    
    let cityName : String
    
    var body: some View {
        VStack{
            Text(cityName)
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
}

#Preview {
    RemoteCityView(cityName: "Napoli")
}
