//
//  WindTileView.swift
//  Wweather
//
//  Created by Simon Naud on 07/12/2024.
//

import SwiftUI

struct WindTileView: View {
    var body: some View {
        ZStack{

            Circle()
                .stroke(style: StrokeStyle(lineWidth: 8, dash: [1, 14]))
                .foregroundStyle(.gray)
                .frame(width: 100, height: 100)
            Image("arrowWind")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.white)
                .frame(height: 105)
                .rotationEffect(Angle(degrees: 24.0))
            Circle()
                .foregroundStyle(Color.deepdark)
                .frame(width: 60, height: 60)
            Circle()
                .foregroundStyle(.white)
                .frame(width: 55, height: 55)
            VStack(spacing: -3){
                Text("100")
                    .foregroundStyle(.gray)
                    .font(.title3)
                    .fontWeight(.semibold)
                Text("km/h")
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            
            
                           
        }
            .frame(width: 180, height: 130)
            .background(Color.deepdark)
            .cornerRadius(25)

        
        
    }
       
}



#Preview {
    WindTileView()
}
