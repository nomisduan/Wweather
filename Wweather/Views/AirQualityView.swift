//
//  AirQualityView.swift
//  Wweather
//
//  Created by Simon Naud on 07/12/2024.
//

import SwiftUI

struct AirQualityView: View {
    var body: some View {
        ZStack(alignment: .topLeading){
            VStack(alignment: .leading, spacing: 1){
                Text("Fair")
                    .foregroundStyle(.white)
                    .font(.title3)
                ZStack {
                    RoundedRectangle(cornerRadius: 4)
                        .frame(width: 140, height: 8)
                        .foregroundStyle(
                            LinearGradient(colors: [.blue, .green, .yellow, .red, .purple], startPoint: .leading, endPoint: .trailing)
                        )
                    Circle()
                        .frame(width: 20)
                        .foregroundStyle(.white)
                        
                }
            }
        }
            .frame(width: 180, height: 70)
            .background(Color.deepdark)
            .cornerRadius(25)
        
    }
}

#Preview {
    AirQualityView()
}
