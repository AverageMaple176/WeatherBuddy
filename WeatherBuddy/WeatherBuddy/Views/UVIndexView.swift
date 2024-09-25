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
            VStack {
                Text("\(value)")
                    .font(.system(size: 50, weight: .light, design: .rounded))
                Text("\(severity.description)")
                    .font(.title3)
            }
            Spacer()
            Image(systemName: "sun.max")
                .font(.system(size: 30))
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20).fill(Color.black.opacity(0.3))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        )
    }
}
