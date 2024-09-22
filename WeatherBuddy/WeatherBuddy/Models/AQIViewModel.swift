//
//  AQIViewModel.swift
//  WeatherBuddy
//
//  Created by Peter Berning on 9/21/24.
//

import Foundation

struct AQIResponse: Decodable {
    let list: [AQIData]
}

struct AQIData: Decodable {
    let main: AQI
    let components: AQIComponents
}

struct AQI: Decodable {
    let aqi: Int
}

struct AQIComponents: Decodable {
    let pm2_5: Double
    let pm10: Double
    let o3: Double
    let no2: Double
    let so2: Double
    let co: Double
}

class AQIViewModel: ObservableObject {
    @Published var aqi: Int = 0
    @Published var description: String = "Unknown"
    @Published var pm25: Double = 0.0
    @Published var pm10: Double = 0.0
    @Published var o3: Double = 0.0
    @Published var no2: Double = 0.0
    @Published var so2: Double = 0.0
    @Published var co: Double = 0.0
    @Published var isLoading = false
    
    func fetchAQI(latitude: Double, longitude: Double) {
        let apiKey = ""
        let urlString = "https://api.openweathermap.org/data/2.5/air_pollution?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)"
        
        guard let url = URL(string: urlString) else { return }
        
        isLoading = true
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
            }
            guard let data = data, error == nil else {
                print("Error fetching AQI data: \(String(describing: error))")
                return
            }
            
            do {
                let airQualityResponse = try JSONDecoder().decode(AQIResponse.self, from: data)
                
                if let firstData = airQualityResponse.list.first {
                    DispatchQueue.main.async {
                        self.aqi = firstData.main.aqi
                        self.description = self.getAQIDescription(aqi: firstData.main.aqi)
                        self.pm25 = firstData.components.pm2_5
                        self.pm10 = firstData.components.pm10
                        self.o3 = firstData.components.o3
                        self.no2 = firstData.components.no2
                        self.so2 = firstData.components.so2
                        self.co = firstData.components.co
                    }
                } else {
                    print("No AQI data available.")
                }
            } catch {
                print("Failed to decode AQI data: \(error)")
            }
        }
        task.resume()
    }
    
    private func getAQIDescription(aqi: Int) -> String {
        switch aqi {
        case 1: return "Good"
        case 2: return "Fair"
        case 3: return "Moderate"
        case 4: return "Poor"
        case 5: return "Very Poor"
        default: return "Unknown"
        }
    }
}
