//
//  TimeTravelBarView2View.swift
//  Wweather
//
//  Created by Simon Naud on 09/12/24.
//

import SwiftUI

struct TimeTravelBarView2View: View {
  
    let numberOfElements = 12
      @State private var touchedElements: [Bool]
      @State private var dragLocation: CGPoint = .zero
      @State private var elementFrames: [CGRect] = Array(repeating: .zero, count: 12) // Cadres des éléments

      init() {
          _touchedElements = State(initialValue: Array(repeating: false, count: numberOfElements))
      }

      var body: some View {
          HStack {
              ZStack {
                  HStack(spacing: 5) {
                      ForEach(0..<numberOfElements, id: \.self) { index in
                          TimeTravelElement2(
                              rectangleTopColor: touchedElements[index] ? .green : .orange,
                              rectangleBottomColor: touchedElements[index] ? .blue : .purple,
                              rectangleTopHeight: 25,
                              rectangleTopWidth: 15,
                              rectangleBottomHeight: 20,
                              rectangleBottomHWidth: 15
                          )
                          .frame(width: 18, height: 60)
                          .background(
                              GeometryReader { geometry in
                                  Color.clear
                                      .onAppear {
                                          // Assure-toi que les cadres sont correctement enregistrés
                                          let frame = geometry.frame(in: .global)
                                          DispatchQueue.main.async {
                                              elementFrames[index] = frame
                                          }
                                      }
                              }
                          )
                      }
                  }

                  Capsule()
                      .frame(width: 350, height: 5)
                      .foregroundStyle(.white)
                      .shadow(radius: 5)
              }
              .contentShape(Rectangle()) // Permet de capturer les gestes partout dans la zone
              .gesture(
                  DragGesture()
                      .onChanged { value in
                          dragLocation = value.location
                          updateTouchedElements()
                      }
                      .onEnded { _ in
                          touchedElements = Array(repeating: false, count: numberOfElements) // Réinitialise les états
                      }
              )
          }
      }

      /// Met à jour les éléments touchés en fonction de la position du doigt
      private func updateTouchedElements() {
          for (index, frame) in elementFrames.enumerated() {
              if frame.contains(dragLocation) {
                  touchedElements[index] = true
              }
          }
      }
  }

  #Preview {
      TimeTravelBarView2View()
  }
