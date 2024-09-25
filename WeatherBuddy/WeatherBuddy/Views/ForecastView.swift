//
//  ContentView.swift
//  WeatherBuddy
//
//  Created by Peter Berning on 9/13/24.
//


import SwiftUI
import WeatherKit
import CoreLocation

struct ForecastView: View {
    @Environment(LocationManager.self) var locationManager
    @Environment(\.scenePhase) var scenePhase
    let weatherManager = WeatherManager.shared
    
    @State private var weatherAlert: WeatherAlert?
    @State private var currentWeather: CurrentWeather?
    @State private var hourlyForecast: Forecast<HourWeather>?
    @State private var dailyForecast: Forecast<DayWeather>?
    @State private var humidity: String?
    @State private var dewPoint: Measurement<UnitTemperature>?
    @State private var wind: Wind?
    @State private var pressure: Measurement<UnitPressure>?
    @State private var pressureTrend: String?
    @State private var uvIndex: UVIndex?
    @State private var showCityList = false
    @State private var isLoading: Bool = false
    @State private var selectedCity: City?
    @State private var timeZone: TimeZone = .current
    @StateObject private var aqiViewModel = AQIViewModel()
    
    
    var highTemperature: String? {
        if let high = dailyForecast?.forecast.map({$0.highTemperature}).first {
            return weatherManager.measurementFormatter.string(from: high)
        } else {
            return nil
        }
    }
    var lowTemperature: String? {
        if let low = dailyForecast?.forecast.map({$0.lowTemperature}).first {
            return weatherManager.measurementFormatter.string(from: low)
        } else {
            return nil
        }
    }
    var dewPointString: String? {
        if let string = currentWeather?.dewPoint {
            return weatherManager.measurementFormatter.string(from: string)
        } else {
            return nil
        }
    }
    var windSpeed: String? {
        if let speed = currentWeather?.wind.speed {
            return weatherManager.measurementFormatter.string(from: speed)
        } else {
            return nil
        }
    }
    var windGust: String? {
        if let gust = currentWeather?.wind.gust {
            return weatherManager.measurementFormatter.string(from: gust)
        } else {
            return nil
        }
    }
    var uvValue: Int? {
        if let value = currentWeather?.uvIndex.value {
            return value
        } else {
            return nil
        }
    }
    var uvSeverity: String? {
        if let severity = currentWeather?.uvIndex.category {
            switch severity {
            case .low:
                return "Low"
            case .moderate:
                return "Moderate"
            case .high:
                return "High"
            case .veryHigh:
                return "Very High"
            case .extreme:
                return "Extreme"
            }
        }
        return "Unknown"
    }
    var pressureValue: String? {
        if let value = currentWeather?.pressure {
            return weatherManager.measurementFormatter.string(from: value)
        } else {
            return nil
        }
    }
    var sunrise: Date? {
        let riseTime = dailyForecast?.first?.sun.sunrise
        return riseTime
    }
    var sunset: Date? {
        let setTime = dailyForecast?.first?.sun.sunset
        return setTime
    }
    var todaySunrise: Date? {
        let date = dailyForecast?[0].sun.sunrise
        return date
    }
    var todaySunset: Date? {
        let date = dailyForecast?[0].sun.sunset
        return date
    }
    var nextSunset: Date? {
        let date = dailyForecast?[1].sun.sunset
        return date
    }
    var nextSunrise: Date? {
        let date = dailyForecast?[0].sun.sunrise
        return date
    }
    
    var alertSummary: String? {
        weatherAlert?.summary
    }
    var alertSource: String? {
        weatherAlert?.source
    }
    var alertURL: URL? {
        weatherAlert?.detailsURL
    }
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue.opacity(0.5), .purple.opacity(0.5)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            if let sunset {
                if (currentWeather?.condition.description == "Mostly Clear" || currentWeather?.condition.description == "Clear") && Date.now > sunset {
                    Image(.night)
                        .frame(width: 40, height: 40)
                } else {
                    BackgroundManager.image(for: currentWeather?.condition.description ?? "Clear")
                        .frame(width: 40, height: 40)
                }
            }
            ScrollView(showsIndicators: false) {
                VStack {
                    if let selectedCity {
                        if isLoading {
                            ProgressView()
                            Text("Fetching Weather...")
                        } else {
                            Text(selectedCity.name)
                                .font(.title)
                            if let currentWeather {
                                CurrentWeatherView(currentWeather: currentWeather, highTemperature: highTemperature, lowTemperature: lowTemperature)
                            }
                            if let alertSummary {
                                if let alertSource {
                                    if let alertURL {
                                        WeatherAlertView(summary: alertSummary, source: alertSource, details: alertURL)
                                    }
                                }
                            }
                            if aqiViewModel.aqi == 4 || aqiViewModel.aqi == 5 {
                                AQIView(aqi: aqiViewModel.aqi, description: aqiViewModel.description, pm2_5: aqiViewModel.pm25, pm10: aqiViewModel.pm10, o3: aqiViewModel.o3, no2: aqiViewModel.no2, so2: aqiViewModel.so2, co: aqiViewModel.co)
                            }
                            if let uvIndex {
                                if let uvValue {
                                    if let uvSeverity {
                                        if uvValue >= 6 {
                                            UVIndexView(UVIndex: uvIndex, value: uvValue, severity: uvSeverity)
                                        }
                                    }
                                }
                            }
                            if let hourlyForecast {
                                HourlyForecastView(hourlyForecast: hourlyForecast, timeZone: timeZone)
                            }
                            if let dailyForecast {
                                DailyForecastView(dailyForecast: dailyForecast, timeZone: timeZone)
                            }
                            Divider()
                            if aqiViewModel.aqi < 5 {
                                AQIView(aqi: aqiViewModel.aqi, description: aqiViewModel.description, pm2_5: aqiViewModel.pm25, pm10: aqiViewModel.pm10, o3: aqiViewModel.o3, no2: aqiViewModel.no2, so2: aqiViewModel.so2, co: aqiViewModel.co)
                            }
                            if let sunrise {
                                if let sunset {
                                    SunView(sunrise: sunrise, sunset: sunset)
                                    
                                }
                            }
                            if let humidity {
                                if let dewPointString {
                                    HumidityView(humidity: humidity, dewPoint: dewPointString)
                                }
                            }
                            if let wind {
                                if let windSpeed {
                                    if let windGust {
                                        WindView(wind: wind, windSpeed: windSpeed, gust: windGust)
                                    }
                                }
                            }
                            if let currentWeather {
                                FeelsLikeView(currentWeather: currentWeather)
                            }
                            if let uvIndex {
                                if let uvValue {
                                    if let uvSeverity {
                                        if uvValue < 6 {
                                            UVIndexView(UVIndex: uvIndex, value: uvValue, severity: uvSeverity)
                                        }
                                    }
                                }
                            }
                            if let pressureValue {
                                if let pressureTrend {
                                    if pressureTrend == "Steady" {
                                        PressureView(pressure: pressureValue, pressureTrend: pressureTrend, trendSign: "equal")
                                    } else if pressureTrend == "Rising" {
                                        PressureView(pressure: pressureValue, pressureTrend: pressureTrend, trendSign: "arrow.up")
                                    } else {
                                        PressureView(pressure: pressureValue, pressureTrend: pressureTrend, trendSign: "arrow.down")
                                    }
                                }
                            }
                            AttributionView()
                                .padding(.top)
                                .tint(.white)
                        }
                    }
                }
                .foregroundStyle(.white)
            }
            .contentMargins(.all, 15, for: .scrollContent)
        }
        .task(id: locationManager.currentLocation) {
            if let currentLocation = locationManager.currentLocation, selectedCity == nil {
                selectedCity = currentLocation
            }
        }
        
        .task(id: selectedCity) {
            if let selectedCity {
                await fetchWeather(for: selectedCity)
                aqiViewModel.fetchAQI(latitude: selectedCity.coordinate.latitude, longitude: selectedCity.coordinate.longitude)
            }
        }
        .safeAreaInset(edge: .bottom) {
            Button {
                showCityList.toggle()
            } label: {
                Image(systemName: "list.star")
            }
            .padding()
            .background(Color(.darkGray))
            .clipShape(Circle())
            .foregroundStyle(.white)
            .padding(.horizontal)
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .fullScreenCover(isPresented: $showCityList) {
            CitiesListView(currentLocation: locationManager.currentLocation, selectedCity: $selectedCity)
        }
        .onChange(of: scenePhase) {
            if scenePhase == .active {
                selectedCity = locationManager.currentLocation
                if let selectedCity {
                    Task {
                        await fetchWeather(for: selectedCity)
                    }
                }
            }
        }
    }
    
    func fetchWeather(for city: City) async {
        isLoading = true
        Task.detached { @MainActor in
            currentWeather = try await weatherManager.currentWeather(for: city.clLocation)
            timeZone = await locationManager.getTimezone(for: city.clLocation)
            hourlyForecast = try await weatherManager.hourlyWeather(for: city.clLocation)
            dailyForecast = try await weatherManager.dailyWeather(for: city.clLocation)
            humidity = try await weatherManager.getHumidity(for: city.clLocation)
            dewPoint = try await weatherManager.getDewPoint(for: city.clLocation)
            wind = try await weatherManager.getWindSpeed(for: city.clLocation)
            uvIndex = try await weatherManager.getUVIndex(for: city.clLocation)
            pressure = try await weatherManager.getPressure(for: city.clLocation)
            pressureTrend = try await weatherManager.getPressureTrend(for: city.clLocation)
            weatherAlert = try await weatherManager.getWeatherAlert(for: city.clLocation)
            
        }
        isLoading = false
    }
}


#Preview {
    ForecastView()
        .environment(LocationManager())
        .environment(DataStore(forPreviews: true))
}

