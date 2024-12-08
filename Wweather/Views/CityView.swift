//
//  CityView.swift
//  Wweather
//
//  Created by Simon Naud on 07/12/2024.
//

import SwiftUI

struct CityView: View {
    
    let cityName : String
    
    var body: some View {
        VStack{
            Text(cityName)
                .font(.system(.largeTitle, design: .serif))
                .fontWeight(.semibold)
                .foregroundStyle(.white)
            Text("13:22")
                .font(.largeTitle)
                .fontWeight(.light)
                .foregroundStyle(.white)
        }
        .frame(width: 180)
    }
}

#Preview {
    CityView(cityName: "Napoli")
}
