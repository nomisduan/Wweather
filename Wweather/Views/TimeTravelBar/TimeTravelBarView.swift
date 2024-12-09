//
//  TimeTravelBarView.swift
//  Wweather
//
//  Created by Simon Naud on 08/12/2024.
//

import SwiftUI

struct TimeTravelBarView: View {
    
    let topCity : String
    let bottomCity : String
    
    var body: some View {
        
        HStack {
            
            
            
            ZStack {
                
                
                HStack{
                    
                    VStack {
                        Text(topCity)
                            .foregroundStyle(.white)
                            .font(.system(.title3, design: .serif))
                        // .padding(.bottom, 5)
                            .frame(width: 30)
                        
                        Text(bottomCity)
                            .foregroundStyle(.white)
                            .font(.system(.title3, design: .serif))
                        // .padding(.bottom, 5)
                            .frame(width: 30)
                        
                    }
                    .padding(.trailing)
                    
                    HStack(spacing: 5) {
                        ForEach((1...12), id: \.self) {_ in
                            TimeTravelElementView(rectangleTopColor: .cyan, rectangleBottomColor: .purple)
                        }
                        .frame(width: 18, height: 60)
                    
                    }
                }
                
                
                
                Capsule()
                    .frame(width: 350, height: 5)
                    .foregroundStyle(.white)
                    .shadow(radius: 5)
            }
        }
    }
}

#Preview {
    ContentView()
}
