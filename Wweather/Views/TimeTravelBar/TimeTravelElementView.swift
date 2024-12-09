//
//  TimeTravelElementView.swift
//  Wweather
//
//  Created by Simon Naud on 08/12/2024.
//

import SwiftUI

struct TimeTravelElementView: View {

    let rectangleTopColor : Color
    let rectangleBottomColor : Color
    @State private var isTouched = false
    
    
    var body: some View {
       
        VStack(spacing:0) {
            UnevenRoundedRectangle(cornerRadii: .init(
                topLeading: 10.0,
                bottomLeading: 0.0,
                bottomTrailing: 0.0,
                topTrailing: 10.0),
                                   style: .continuous)
            
            .frame(width: isTouched ? 25 : 15, height: isTouched ? 36 : 25)
            .shadow(radius: isTouched ? 3 : 0)
            .foregroundStyle(rectangleTopColor)
            .animation(.easeInOut(duration: 0.2), value: isTouched)
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { _ in
                                    isTouched = true
                                }
                                .onEnded { _ in
                                    isTouched = false
                                }
            )
            
            
            UnevenRoundedRectangle(cornerRadii: .init(
                
                topLeading: 0.0,
                bottomLeading: 10.0,
                bottomTrailing: 10.0,
                topTrailing: 0.0),
                                   style: .continuous)
            .frame(width: isTouched ? 25 : 15, height: isTouched ? 31 : 20)
            .shadow(radius: isTouched ? 3 : 0)
            .foregroundStyle(rectangleBottomColor)
            .animation(.easeInOut(duration: 0.2), value: isTouched)
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { _ in
                                    isTouched = true
                                }
                                .onEnded { _ in
                                    isTouched = false 
                                }
                            )
            
            
        }
    }
}
#Preview {
    TimeTravelElementView(rectangleTopColor: .blue, rectangleBottomColor: .orange)
}
