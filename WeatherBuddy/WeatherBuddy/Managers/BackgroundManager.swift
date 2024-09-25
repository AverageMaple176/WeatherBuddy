//
//  BackgroundManager.swift
//  WeatherBuddy
//
//  Created by Peter Berning on 9/14/24.
//

import SwiftUI
import WeatherKit

struct BackgroundManager {

    static func image(for weatherCondition: String) -> Image {
        switch weatherCondition {
        
        case "Clear", "Windy", "Mostly Clear":
            return Image(.clear)
            
        case "Partly Cloudy", "Mostly Cloudy":
            return Image(.partlyCloudy)
        
        case "Cloudy":
            return Image(.cloudy)
        
        case "Rain", "Drizzle", "Heavy Rain":
            return Image(.rain)
        
        case "Thunderstorm", "Isolate Thunderstorm", "Scattered Thunderstorms":
            return Image(.thunderstorm)
        
        case "Snow":
            return Image(.snow)
        
        case "Foggy":
            return Image(.cloudy)
        
        case "Haze", "Smoky":
            return Image(.smoky)
        case "Tropical Storm", "Hurricane":
            return Image(.cloudy)
        
        default:
            return Image(.clear)
        }
    }
}
