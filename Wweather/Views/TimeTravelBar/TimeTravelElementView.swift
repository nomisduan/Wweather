//
//  TimeTravelElementView.swift
//  Wweather
//
//  Created by Simon Naud on 08/12/2024.
//

import SwiftUI

struct TimeTravelElementView: View {

    let roundedTop : Bool
    let rectangleColor : Color
    
    var body: some View {
        if roundedTop == true {
            UnevenRoundedRectangle(cornerRadii: .init(
                
                                                                topLeading: 10.0,
                                                                bottomLeading: 0.0,
                                                                bottomTrailing: 0.0,
                                                                topTrailing: 10.0),
                                                                style: .continuous)
                .frame(width: 15, height: 20)
                .foregroundStyle(rectangleColor)
        } else {
            UnevenRoundedRectangle(cornerRadii: .init(
                
                                                                topLeading: 0.0,
                                                                bottomLeading: 10.0,
                                                                bottomTrailing: 10.0,
                                                                topTrailing: 0.0),
                                                                style: .continuous)
                .frame(width: 15, height: 15)
                .foregroundStyle(rectangleColor)
        }
            
   
    }
}
#Preview {
    TimeTravelElementView(roundedTop: true, rectangleColor: .blue)
}
