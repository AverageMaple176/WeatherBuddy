//
//  HumidityView.swift
//  WeatherBuddy
//
//  Created by Peter Berning on 9/14/24.
//

import SwiftUI
import WeatherKit

struct HumidityView: View {
    let weatherManager = WeatherManager.shared
    let humidity: String
    let dewPoint: String
    
    var body: some View {
        HStack {
            Text("Humdity")
                .font(.title2)
            Spacer()
            Text(humidity)
                .font(.system(size: 50, weight: .light, design: .rounded))
            Spacer()
            VStack {
                Image(systemName: "humidity")
                    .font(.system(size: 30))
                Text("Dew Point: \(dewPoint)")
                    .font(.title3)
                    .multilineTextAlignment(.center)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20).fill(Color.white.opacity(0.2))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        )
    }
}
