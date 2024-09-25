//
//  WeatherBuddyApp.swift
//  WeatherBuddy
//
//  Created by Peter Berning on 9/13/24.
//

import SwiftUI

@main
struct WeatherBuddyApp: App {
    @State private var locationManager = LocationManager()
    @State private var store = DataStore()
    @State private var weatherManager = WeatherManager()
    
    
    var body: some Scene {
        WindowGroup {
            if locationManager.isAuthorized {
                ForecastView()
            } else {
                LocationDeniedView()
            }
        }
        .environment(locationManager)
        .environment(store)
    }
}
