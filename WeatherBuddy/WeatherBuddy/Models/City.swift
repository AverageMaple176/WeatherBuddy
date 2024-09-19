//
//  City.swift
//  WeatherBuddy
//
//  Created by Peter Berning on 9/14/24.
//

import Foundation
import CoreLocation

struct City: Identifiable, Hashable, Codable {
    var id = UUID()
    var name: String
    var latitude: Double
    var longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    var clLocation: CLLocation {
        CLLocation(latitude: latitude, longitude: longitude)
    }
    
    static var cities: [City] {
        [
            .init(name: "San Francisco", latitude: 37.7749, longitude: -122.4194),
            .init(name: "Paris", latitude: 48.856788, longitude: 2.351077),
            .init(name: "Sydney", latitude: -33.872710, longitude: 151.205694)
        ]
    }
    
    static var mockCurrent: City {
        .init(name: "Cochrane", latitude: 51.197418, longitude: 114.49765)
    }
    
}
