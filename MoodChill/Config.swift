//
//  Config.swift
//  MoodChill
//
//  Created by Dimitris Poluzos on 22/3/26.
//


import Foundation

struct Config {
    static var apiKey: String {
        Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String ?? ""
    }
}
