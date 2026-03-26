//
//  NetworkClient.swift
//  MoodChill
//
//  Created by Dimitris Poluzos on 19/3/26.
//

import Foundation


class NetworkClient {
    
    func fetchQuote(mood: Mood) async throws -> Quote {
        
        let category = mood.quoteCategory
        
        let url = URL(string: "https://api.api-ninjas.com/v2/quotes?category=\(category)")!
        
        var request = URLRequest(url: url)
        request.setValue(Config.apiKey, forHTTPHeaderField: "X-Api-Key")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let quotes = try JSONDecoder().decode([Quote].self, from: data)
        
        guard let first = quotes.first else {
            throw URLError(.badServerResponse)
        }
        
        return first
    }
    
    func fetchSong(mood: Mood) async throws -> Song {
        let term = mood.searchTerm
        
        let url = URL(string: "https://itunes.apple.com/search?term=\(term)&entity=song&limit=10")!
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let response = try JSONDecoder().decode(SongResponse.self, from: data)
        
        guard let song = response.results.randomElement() else {
            throw URLError(.badServerResponse)
        }
        
        return song
    }
    
    func fetchShow(mood: Mood) async throws -> Show {
        
        let term = mood.movieGenre
        
        let url = URL(string: "https://api.tvmaze.com/search/shows?q=\(term)")!
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let response = try JSONDecoder().decode([ShowResponse].self, from: data)
        
        guard let show = response.randomElement()?.show else {
            throw URLError(.badServerResponse)
        }
        
        return show
    }
    
    func fetchWeather() async throws -> CurrentCondition {

        guard let url = URL(string: "https://wttr.in/Athens?format=j1") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        

        let response = try JSONDecoder().decode(WeatherResponse.self, from: data)
        

        guard let current = response.current_condition.first else {
            throw NSError(domain: "No data", code: 0, userInfo: nil)
        }
        
        return current
    }}

