//
//  UVIndexView.swift
//  WeatherBuddy
//
//  Created by Peter Berning on 9/15/24.
//

import SwiftUI
import WeatherKit

struct UVIndexView: View {
    let weatherManager = WeatherManager.shared
    let UVIndex: UVIndex
    let value: Int
    let severity: String
    
    var body: some View {
        HStack {
            Text("UV Index")
                .font(.title2)
            Spacer()
            Text("\(value)")
                .font(.system(size: 50, weight: .light, design: .rounded))
            Spacer()
            Text("\(severity.description)")
                .font(.title3)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20).fill(Color.white.opacity(0.2))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        )
    }
}
