//
//  NetworkClient.swift
//  MoodChill
//
//  Created by Dimitris Poluzos on 19/3/26.
//

import Foundation


class NetworkClient {
    
    func fetchQuote() async throws -> Quote {
        let url = URL(string: "https://dummyjson.com/quotes/random")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let quote = try JSONDecoder().decode(Quote.self, from: data)
        return quote
    }
}
