//
//  CurrentWeatherView.swift
//  WeatherBuddy
//
//  Created by Peter Berning on 9/14/24.
//

import SwiftUI
import WeatherKit

struct CurrentWeatherView: View {
    let weatherManager = WeatherManager.shared
    let currentWeather: CurrentWeather
    let highTemperature: String?
    let lowTemperature: String?
    let timeZone: TimeZone
    
    var body: some View {
        Image(systemName: currentWeather.symbolName)
            .renderingMode(.original)
            .symbolVariant(.fill)
            .font(.system(size: 60, weight: .bold))
            .padding(.top)
        let temp = weatherManager.measurementFormatter.string(from: currentWeather.temperature)
        Text(temp)
            .font(.system(size: 60, weight: .light, design: .rounded))
            .padding(.bottom)
        if let highTemperature, let lowTemperature {
            Text("L: \(lowTemperature)  H: \(highTemperature)")
                .font(.system(size: 20))
        }
        Text(currentWeather.condition.description)
            .font(.title3)
            .padding(.bottom)
    }
}
