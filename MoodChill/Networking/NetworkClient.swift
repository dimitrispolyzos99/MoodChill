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
}


