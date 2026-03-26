//
//  Weather.swift
//  MoodChill
//
//  Created by Dimitris Poluzos on 23/3/26.
//

import Foundation


import Foundation

struct WeatherResponse: Decodable {
    let current_condition: [CurrentCondition]
}

struct CurrentCondition: Decodable {
    let temp_C: String
    let weatherCode: String
    let weatherDesc: [Description]

    var descriptionText: String {
        weatherDesc.first?.value ?? "Unknown"
    }
}

struct Description: Decodable {
    let value: String
}
