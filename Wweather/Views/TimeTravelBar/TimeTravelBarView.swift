//
//  TimeTravelBarView.swift
//  Wweather
//
//  Created by Simon Naud on 08/12/2024.
//

import SwiftUI

struct TimeTravelBarView: View {
    var body: some View {
        
        ZStack(alignment: .center) {
           
            VStack (spacing: 0){
                HStack{
                    HStack{
                        Text("Na")
                            .foregroundStyle(.white)
                            .font(.system(.body, design: .serif))
                           // .padding(.bottom, 5)
                    }
                    .frame(width: 30)
                    ForEach((1...12).reversed(), id: \.self) {_ in
                        TimeTravelElementView(roundedTop: true, rectangleColor: .gray)
                    }
                }
                
                HStack{
                    HStack{
                        Text("Mo")
                            .foregroundStyle(.white)
                            .font(.system(.body, design: .serif))
                            //.padding(.top, 5)
                    }
                    .frame(width: 30)
                    ForEach((1...12).reversed(), id: \.self) {_ in
                        TimeTravelElementView(roundedTop: false, rectangleColor: .gray)
                            
                    }
                }
            }
            Capsule()
                .frame(width: 350, height: 5)
                .foregroundStyle(.white)
                .shadow(radius: 5)
        }
    }
}

#Preview {
    ContentView()
}
