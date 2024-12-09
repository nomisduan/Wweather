//
//  TimeTravelElement2.swift
//  Wweather
//
//  Created by Simon Naud on 09/12/24.
//

import SwiftUI

struct TimeTravelElement2: View {
    let rectangleTopColor : Color
    let rectangleBottomColor : Color
    var rectangleTopHeight : CGFloat
    var rectangleTopWidth : CGFloat
    var rectangleBottomHeight : CGFloat
    var rectangleBottomHWidth : CGFloat

    var body: some View {
       
        VStack(spacing:0) {
            UnevenRoundedRectangle(cornerRadii: .init(
                topLeading: 10.0,
                bottomLeading: 0.0,
                bottomTrailing: 0.0,
                topTrailing: 10.0),
                                   style: .continuous)
            
            .frame(width: rectangleTopWidth, height: rectangleTopHeight)
            .foregroundStyle(rectangleTopColor)
            
            
            
            UnevenRoundedRectangle(cornerRadii: .init(
                
                topLeading: 0.0,
                bottomLeading: 10.0,
                bottomTrailing: 10.0,
                topTrailing: 0.0),
                                   style: .continuous)
            .frame(width: rectangleBottomHWidth, height: rectangleBottomHeight)
            .foregroundStyle(rectangleBottomColor)
            
            
            
        }
    }
}
#Preview {
    TimeTravelElement2(rectangleTopColor: .blue, rectangleBottomColor: .orange, rectangleTopHeight: 25, rectangleTopWidth: 15, rectangleBottomHeight: 20, rectangleBottomHWidth: 15)
}
