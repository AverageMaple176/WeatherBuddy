//
//  CityRowView.swift
//  WeatherBuddy
//
//  Created by Peter Berning on 9/14/24.
//

import SwiftUI
import WeatherKit

struct CityRowView: View {
    let weatherManager = WeatherManager.shared
    @Environment(LocationManager.self) var locationManager
    @State private var currentWeather: CurrentWeather?
    @State private var isLoading: Bool = false
    @State private var timeZone: TimeZone = .current
    let city: City
    
    var body: some View {
        VStack {
            if isLoading {
                ProgressView()
            } else {
                if let currentWeather {
                    VStack(alignment: .leading) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(city.name)
                                    .font(.title)
                                    .scaledToFill()
                                    .minimumScaleFactor(0.5)
                                    .lineLimit(1)
                            }
                            Spacer()
                            let temp = weatherManager.measurementFormatter.string(from: currentWeather.temperature)
                            Text(temp)
                                .font(.system(size: 60, weight: .thin, design: .rounded))
                                .fixedSize(horizontal: true, vertical: true)
                        }
                        Text(currentWeather.condition.description)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                }
            }
        }
        .task(id: city) {
            await fetchWeather(for: city)
        }
    }
    
    func fetchWeather(for city: City) async {
        isLoading = true
        Task.detached { @MainActor in
            currentWeather = try await weatherManager.currentWeather(for: city.clLocation)
            timeZone = await locationManager.getTimezone(for: city.clLocation)
            
        }
        isLoading = false
    }
}

#Preview {
    CityRowView(city: City.mockCurrent)
        .environment(LocationManager())
}
