//
//  WeatherManager.swift
//  WeatherBuddy
//
//  Created by Peter Berning on 9/14/24.
//

import Foundation
import WeatherKit
import CoreLocation
import SwiftUI

class WeatherManager {
    static let shared = WeatherManager()
    let service = WeatherService.shared
    
    
    var measurementFormatter: MeasurementFormatter {
        let formatter = MeasurementFormatter()
        formatter.unitOptions = .temperatureWithoutUnit
        formatter.numberFormatter.roundingMode = .up
        formatter.numberFormatter.maximumFractionDigits = 0
        return formatter
    }
    
    func currentWeather(for location: CLLocation) async throws -> CurrentWeather? {
        let currentWeather = await Task.detached(priority: .userInitiated) {
            let forecast = try? await self.service.weather(
                for: location,
                including: .current
            )
            return forecast
        }.value
        return currentWeather
    }
    
    func hourlyWeather(for location: CLLocation) async throws -> Forecast<HourWeather>? {
        let hourlyForecast = await Task.detached(priority: .userInitiated) {
            let forecast = try? await self.service.weather(
                for: location,
                including: .hourly
            )
            return forecast
        }.value
        return hourlyForecast
    }
    
    func dailyWeather(for location: CLLocation) async throws -> Forecast<DayWeather>? {
        let dailyForecast = await Task.detached(priority: .userInitiated) {
            let forecast = try? await self.service.weather(
                for: location,
                including: .daily
            )
            return forecast
        }.value
        return dailyForecast
    }
    
    func getHumidity(for location: CLLocation) async throws -> String? {
        let humidity = await Task.detached(priority: .userInitiated) {
            let forecast = try? await self.service.weather(
                for: location,
                including: .current
            )
            return forecast?.humidity
        }.value
        let computedHumidity = String(Int((humidity ?? 0) * 100)) + "%"
        return computedHumidity
    }
    
    func getDewPoint(for location: CLLocation) async throws -> Measurement<UnitTemperature>? {
        let dewPoint = await Task.detached(priority: .userInitiated) {
            let forecast = try? await self.service.weather(
                for: location,
                including: .current
            )
            return forecast?.dewPoint
        }.value
        return dewPoint
    }
    
    func getWindSpeed(for location: CLLocation) async throws -> Wind? {
        let windSpeed = await Task.detached(priority: .userInitiated) {
            let forecast = try? await self.service.weather(
                for: location,
                including: .current
            )
            return forecast?.wind
        }.value
        return windSpeed
    }
    
    func getUVIndex(for location: CLLocation) async throws -> UVIndex? {
        let uvIndex = await Task.detached(priority: .userInitiated) {
            let forecast = try? await self.service.weather(
                for: location,
                including: .current
            )
            return forecast?.uvIndex
        }.value
        return uvIndex 
    }
    
    func getPressure(for location: CLLocation) async throws -> Measurement<UnitPressure>? {
        let pressure = await Task.detached(priority: .userInitiated) {
            let forecast = try? await self.service.weather(
                for: location,
                including: .current
            )
            return forecast?.pressure
        }.value
        return pressure
    }
    
    func getPressureTrend(for location: CLLocation) async throws -> String? {
        let pressureTrend = await Task.detached(priority: .userInitiated) {
            let forecast = try? await self.service.weather(
                for: location,
                including: .current
            )
            return forecast?.pressureTrend.description.capitalized
        }.value
        return pressureTrend
    }
    
    func getWeatherAlert(for location: CLLocation) async throws -> WeatherAlert? {
        let weatherAlert = await Task.detached(priority: .userInitiated) {
            let forecast = try? await self.service.weather(
                for: location,
                including: .alerts
            )
            return forecast?.first
        }.value
        return weatherAlert
    }
    
    func weatherAttribution() async -> WeatherAttribution? {
        let attribution = await Task(priority: .userInitiated) {
            return try? await self.service.attribution
        } .value
        return attribution
    }
    
}
