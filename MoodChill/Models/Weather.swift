//
//  Weather.swift
//  MoodChill
//
//  Created by Dimitris Poluzos on 23/3/26.
//

import Foundation


import Foundation

struct OpenMeteoResponse: Decodable {
    let current_weather: CurrentWeather
}

struct CurrentWeather: Decodable {
    let temperature: Double
    let weathercode: Int
    let is_day: Int
}
