//
//  SunView.swift
//  WeatherBuddy
//
//  Created by Peter Berning on 9/18/24.
//

import SwiftUI
import WeatherKit

struct SunView: View {
    let weatherManager = WeatherManager.shared
    let sunrise: String
    let sunset: String
    let todaySunrise: Date
    let todaySunset: Date
    let nextSunrise: Date
    let nextSunset: Date
    
    
    var body: some View {
        HStack {
            if Date.now > todaySunset {
                VStack {
                    Text("Sunrise")
                        .font(.title3)
                    Image(systemName: "sunrise")
                        .font(.system(size: 30))
                }
                Spacer()
                Text("\(nextSunrise.formatted(date: .omitted, time: .shortened))")
                    .font(.system(size: 50, weight: .light, design: .rounded))
                Spacer()
                
            } else if Date.now > todaySunrise {
                VStack {
                    Text("Sunset")
                        .font(.title3)
                    Image(systemName: "sunset")
                        .font(.system(size: 30))
                }
                Spacer()
                Text("\(nextSunset.formatted(date: .omitted, time: .shortened))")
                    .font(.system(size: 40, weight: .light, design: .rounded))
                Spacer()
                
            }
            
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20).fill(Color.white.opacity(0.2))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        )
    }
}
