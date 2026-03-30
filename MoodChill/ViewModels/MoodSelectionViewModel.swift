//
//  RecomendationViewModel.swift
//  MoodChill
//
//  Created by Dimitris Poluzos on 19/3/26.
//

import Foundation
import Combine



@MainActor
class MoodSelectionViewModel : ObservableObject {
    
    @Published var weather: CurrentWeather?
    
    let networkClient = NetworkClient()
    let locationManager = LocationManager()
    
    func requestLocation() {
        locationManager.requestLocation()
    }
    
    func fetchWeatherForCurrentLocation() async {
        for _ in 0..<20{
            if let lat = locationManager.latitude,
               let lon = locationManager.longitude {
                
                do {
                    let result = try await networkClient.fetchWeather(lat: lat, lon: lon)
                    weather = result.current_weather
                } catch {
                    print("Weather error:", error)
                }
            
            return
        }
        try? await Task.sleep(nanoseconds: 300_000_000)
    }
    print("Location was not ready in time")
}
    
    func getBackgroundName(for code: Int, isDay: Bool) -> String {
        if isDay{
            switch code{
            case 0:
                return "sunny_bg"
            case 1, 2, 3, 45, 48:
                return "cloudy_bg"
            case 51, 53, 55, 61, 63, 65, 80, 81, 82:
                return "rainy_bg"
            case 95, 96, 99:
                return "stormy_bg"
            case 71, 73, 75, 77, 85, 86:
                return "snowy_bg"
            default:
                return "default_bg"
            }
        } else {
            switch code {
            case 0:
                return "clear_night"
            case 1, 2, 3, 45, 48:
                return "cloudy_night"
            case 51, 53, 55, 61, 63, 65, 80, 81, 82:
                return "rainy_night"
            case 95, 96, 99:
                return "stormy_night"
            case 71, 73, 75, 77, 85, 86:
                return "snowy_night"
            default:
                return "default_bg"
            }
        }
    }
    
    func getWeatherIcon(for code: Int, isDay: Bool) -> String {
        if isDay{
            switch code {
            case 0: return "sun.max.fill"
            case 1, 2: return "cloud.sun.fill"
            case 3, 45, 48: return "cloud.fill"
            case 51, 53, 55, 61, 63, 65, 80, 81, 82: return "cloud.rain.fill"
            case 95, 96, 99: return "cloud.bolt.rain.fill"
            case 71, 73, 77, 85, 86: return "snowflake"
            default: return "questionmark.diamond.fill"
            }
        }
        else {
            switch code {
            case 0: return "moon.stars.fill"
            case 1, 2: return "cloud.moon.fill"
            case 3, 45, 48: return "cloud.fill"
            case 51, 53, 55, 61, 63, 65, 80, 81, 82: return "cloud.rain.fill"
            case 95, 96, 99: return "cloud.bolt.rain.fill"
            case 71, 73, 77, 85, 86: return "snowflake"
            default: return "questionmark.diamond.fill"
                }
        }
    }
}

