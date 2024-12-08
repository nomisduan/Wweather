//
//  SunPathView.swift
//  Wweather
//
//  Created by Simon Naud on 08/12/2024.
//

import SwiftUI
import Charts

struct SunPathView: View {
    // Latitude et longitude pour les calculs
    let latitude: Double = 48.8566 // Paris
    let longitude: Double = 2.3522
    
    // Données pour la courbe
    @State private var sunPathData: [SunData] = []
    @State private var currentTime: Double = 12.0 // Heure actuelle
    @State private var currentElevation: Double = 0.0 // Élévation actuelle
    
    // Timer pour mettre à jour la position
    let timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()
    
    var body: some View {
        Chart {
            // Trajectoire du soleil
            ForEach(sunPathData) { data in
                LineMark(
                    x: .value("Time", data.time),
                    y: .value("Elevation", data.elevation)
                )
                .foregroundStyle(.yellow)
            }
            
            // Ligne d'horizon
            RuleMark(y: .value("Horizon", 0))
                .foregroundStyle(.gray)
                .lineStyle(StrokeStyle(lineWidth: 1, dash: [3]))
            
            // Point représentant la position actuelle du soleil
            PointMark(
                x: .value("Current Time", currentTime),
                y: .value("Current Elevation", currentElevation)
            )
            .foregroundStyle(.red)
            .symbolSize(100)
        }
        .chartYScale(domain: -10...90) // Plage d'altitudes
        .padding()
        .onAppear {
            // Générer la courbe complète
            sunPathData = generateSunPath()
        }
        .onReceive(timer) { _ in
            // Mettre à jour la position actuelle
            updateCurrentPosition()
        }
    }
    
    // Génère la trajectoire complète du soleil pour 24h
    func generateSunPath() -> [SunData] {
        var data: [SunData] = []
        for hour in stride(from: 0.0, to: 24.0, by: 0.1) { // Plus de points pour une courbe lisse
            let elevation = calculateElevation(for: hour)
            data.append(SunData(time: hour, elevation: elevation))
        }
        return data
    }
    
    // Met à jour la position actuelle du soleil
    func updateCurrentPosition() {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        
        // Heure actuelle en décimal (ex : 14:30 = 14.5)
        currentTime = Double(hour) + Double(minute) / 60.0
        
        // Utiliser la même fonction pour calculer l'élévation actuelle
        currentElevation = calculateElevation(for: currentTime)
    }
    
    // Calcul simplifié de l'élévation du soleil
    func calculateElevation(for time: Double) -> Double {
        let maxElevation = 50.0
        return maxElevation * sin((time / 24.0) * .pi) // Courbe en sinus
    }
}

// Modèle de données
struct SunData: Identifiable {
    let id = UUID()
    let time: Double // Heure
    let elevation: Double // Élévation
}

#Preview {
    SunPathView()
}
