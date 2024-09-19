//
//  BackgroundManager.swift
//  WeatherBuddy
//
//  Created by Peter Berning on 9/14/24.
//

import SwiftUI
import WeatherKit

struct WeatherGradientManager {

    static func gradient(for weatherCondition: String) -> LinearGradient {
        switch weatherCondition {
        
        case "Clear", "Windy", "Mostly Clear":
            return LinearGradient(
                gradient: Gradient(colors: [Color.purple, Color.orange]),
                startPoint: .top,
                endPoint: .bottom
            )
        
        case "Cloudy", "Partly Cloudy", "Mostly Cloudy":
            return LinearGradient(
                gradient: Gradient(colors: [Color.gray, Color.purple]),
                startPoint: .top,
                endPoint: .bottom
            )
        
        case "Rain", "Drizzle", "Heavy Rain":
            return LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.5), Color.gray]),
                startPoint: .top,
                endPoint: .bottom
            )
        
        case "Thunderstorm", "Isolate Thunderstorm", "Scattered Thunderstorms":
            return LinearGradient(
                gradient: Gradient(colors: [Color.purple, Color.black]),
                startPoint: .top,
                endPoint: .bottom
            )
        
        case "Snow":
            return LinearGradient(
                gradient: Gradient(colors: [Color.white, Color.gray]),
                startPoint: .top,
                endPoint: .bottom
            )
        
        case "Foggy":
            return LinearGradient(
                gradient: Gradient(colors: [Color.gray, Color.white.opacity(0.2)]),
                startPoint: .top,
                endPoint: .bottom
            )
        
        case "Haze", "Smoky":
            return LinearGradient(
                gradient: Gradient(colors: [Color.orange, Color.gray]),
                startPoint: .top,
                endPoint: .bottom
            )
        
        case "Tropical Storm", "Hurricane":
            return LinearGradient(
                gradient: Gradient(colors: [Color.red, Color.blue]),
                startPoint: .top,
                endPoint: .bottom
            )
        
        default:
            return LinearGradient(
                gradient: Gradient(colors: [Color.purple, Color.orange]),
                startPoint: .top,
                endPoint: .bottom
            )
        }
    }
}
