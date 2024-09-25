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
    let sunrise: Date
    let sunset: Date
    
    
    var body: some View {
        HStack {
            if Date.now < sunrise {
                Text("Sunrise")
                    .font(.title3)
                
                Spacer()
                Text("\(sunrise.formatted(date: .omitted, time: .shortened))")
                    .font(.system(size: 50, weight: .light, design: .rounded))
                Spacer()
                Image(systemName: "sunrise")
                    .font(.system(size: 30))
                
            } else if Date.now > sunrise {
                Text("Sunset")
                    .font(.title3)
                
                Spacer()
                Text("\(sunset.formatted(date: .omitted, time: .shortened))")
                    .font(.system(size: 40, weight: .light, design: .rounded))
                Spacer()
                Image(systemName: "sunset")
                    .font(.system(size: 30))
            }
            
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20).fill(Color.black.opacity(0.3))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        )
    }
}
