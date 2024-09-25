//
//  AQIView.swift
//  WeatherBuddy
//
//  Created by Peter Berning on 9/21/24.
//

import SwiftUI

struct AQIView: View {
    let aqi: Int
    let description: String
    let pm2_5: Double
    let pm10: Double
    let o3: Double
    let no2: Double
    let so2: Double
    let co: Double
    
    @State private var showSheet: Bool = false
    
    
    var body: some View {
        HStack {
            VStack {
                Text("Air Quality")
                    .font(.title2)
            }
            Spacer()
            VStack {
                Text("\(aqi)")
                    .font(.system(size: 50, weight: .light, design: .rounded))
                Text("\(description)")
            }
            Spacer()
            if aqi == 1 || aqi == 2 {
                Image(systemName: "aqi.low")
                    .font(.system(size: 30))
            } else if aqi == 3 {
                Image(systemName: "aqi.medium")
                    .font(.system(size: 30))
            } else if aqi == 4 || aqi == 5 {
                Image(systemName: "aqi.high")
                    .font(.system(size: 30))
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20).fill(Color.black.opacity(0.3))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        )
        .onTapGesture {
            showSheet = true
        }
        .sheet(isPresented: $showSheet) {
            AQIDetailView(aqi: aqi, description: description, pm2_5: pm2_5, pm10: pm10, o3: o3, no2: no2, so2: so2, co: co)
        }
    }
}

