//
//  RecomendationViewModel.swift
//  MoodChill
//
//  Created by Dimitris Poluzos on 19/3/26.
//

import Foundation
import Combine

class MoodSelectionViewModel : ObservableObject {
    
    @Published var weather: CurrentCondition?
    
    let networkClient = NetworkClient()
    
    func fetchWeather() async {
        
        do {
            let result = try await networkClient.fetchWeather()
            weather = result
        } catch {
            print(error)
        }
    }
    
    func getBackgroundName(for code: String) -> String {
        switch code {
        case "113":
            return "sunny_bg"
        case "116", "119", "122", "143", "248", "260":
            return "cloudy_bg"
        case "176", "263", "266", "293", "296", "299", "302", "305", "308", "353", "356":
            return "rainy_bg"
        case "200", "386", "389":
            return "stormy_bg"
        case "179", "182", "227", "230", "323", "326", "329", "332", "335", "338":
            return "snowy_bg"
        default:
            return "default_bg"
        }
    }
    func getWeatherIcon(for code: String) -> String {
        switch code {
        case "113": return "sun.max.fill"
        case "116", "119": return "cloud.sun.fill"
        case "122": return "cloud.fill"
        case "293", "296", "302": return "cloud.rain.fill"
        case "386", "389": return "cloud.bolt.rain.fill"
        case "323", "338": return "snowflake"
        default: return "questionmark.diamond.fill"
        }
    }
}
