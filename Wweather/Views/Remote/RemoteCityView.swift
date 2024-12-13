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
                HStack(spacing: 1) {
                    
                    Text(city)
                        .frame(height: 50)
                        .font(.system(.largeTitle, design: .serif))
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                    Image(systemName: "pencil")
                        .font(.title3)
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

