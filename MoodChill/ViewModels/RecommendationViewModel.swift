//
//  RecommendationViewModel.swift
//  MoodChill
//
//  Created by Dimitris Poluzos on 19/3/26.
//

import Foundation
import Combine

class RecommendationViewModel : ObservableObject {
    
    @Published var quote: Quote?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    
    
    let networkClient = NetworkClient()
    
    var quoteDisplayText: String {
        if isLoading {
            "Loading"
        } else if let quote = quote {
            "\"\(quote.quote)\"\n\n - \(quote.author)"
        } else {
            errorMessage ?? "Something went wrong"
        }
    }
    
    

    func fetchQuote() async {
        isLoading = true
        errorMessage = nil
        do {
            let result =  try await networkClient.fetchQuote()
            quote = result
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    
    
}
