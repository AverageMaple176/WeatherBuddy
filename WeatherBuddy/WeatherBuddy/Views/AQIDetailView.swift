//
//  AQIDetailView.swift
//  WeatherBuddy
//
//  Created by Peter Berning on 9/21/24.
//

import SwiftUI

struct AQIDetailView: View {
    let aqi: Int
    let description: String
    let pm2_5: Double
    let pm10: Double
    let o3: Double
    let no2: Double
    let so2: Double
    let co: Double
    
    var body: some View {
        VStack {
            if aqi == 1 || aqi == 2 {
                Image(systemName: "aqi.low")
                    .font(.system(size: 70))
                    .padding(.top)
            } else if aqi == 3 {
                Image(systemName: "aqi.medium")
                    .font(.system(size: 70))
                    .padding(.top)
            } else if aqi == 4 || aqi == 5 {
                Image(systemName: "aqi.high")
                    .font(.system(size: 70))
            }
            Text("Current AQI: \(aqi)")
            Text(description)
            Spacer()
            List {
                Text("PM2.5: \(pm2_5.formatted()) µg/m³")
                    .font(.system(size: 20))
                Text("PM10: \(pm10.formatted()) µg/m³")
                    .font(.system(size: 20))
                Text("O3: \(o3.formatted()) µg/m³")
                    .font(.system(size: 20))
                Text("NO2: \(no2.formatted()) µg/m³")
                    .font(.system(size: 20))
                Text("SO2: \(so2.formatted()) µg/m³")
                    .font(.system(size: 20))
                Text("CO: \(co.formatted()) µg/m³")
                    .font(.system(size: 20))
            }
            Spacer()
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    AQIDetailView(aqi: 3, description: "Fair", pm2_5: 0.0, pm10: 0.0, o3: 0.0, no2: 0.0, so2: 0.0, co: 0.0)
}
