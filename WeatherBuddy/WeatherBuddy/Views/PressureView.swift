//
//  PressureView.swift
//  WeatherBuddy
//
//  Created by Peter Berning on 9/18/24.
//

import SwiftUI
import WeatherKit

struct PressureView: View {
    let weatherManager = WeatherManager.shared
    let pressure: String
    let pressureTrend: String
    let trendSign: String
    
    var body: some View {
        HStack {
            Text("Pressure")
                .font(.title2)
            Spacer()
            Text(pressure)
                .font(.system(size: 40, weight: .light, design: .rounded))
            Spacer()
            VStack {
                if trendSign == "arrow.down" || trendSign == "equal" {
                    Image(systemName: trendSign)
                        .font(.system(size: 30))
                    Text(pressureTrend)
                        .font(.title3)
                } else {
                    Text(pressureTrend)
                        .font(.title3)
                    Image(systemName: trendSign)
                        .font(.system(size: 30))
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20).fill(Color.white.opacity(0.2))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        )
    }
}
