//
//  WindView.swift
//  WeatherBuddy
//
//  Created by Peter Berning on 9/14/24.
//

import SwiftUI
import WeatherKit

struct WindView: View {
    let weatherManager = WeatherManager.shared
    let wind: Wind
    let windSpeed: String
    let gust: String
    @State var windScreen: Bool = false
    
    var body: some View {
        HStack {
            Text("Wind")
                .font(.title2)
            Spacer()
            VStack {
                Text(windSpeed)
                    .font(.system(size: 40, weight: .light, design: .rounded))
                Text("\(wind.compassDirection)")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
            }
            Spacer()
            VStack {
                Image(systemName: "wind")
                    .font(.system(size: 30))
                Text("Gusts up to \n \(gust)")
                    .multilineTextAlignment(.center)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20).fill(Color.black.opacity(0.3))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        )
    }
}
