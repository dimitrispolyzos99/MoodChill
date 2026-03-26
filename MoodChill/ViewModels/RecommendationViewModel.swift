//
//  RecommendationViewModel.swift
//  MoodChill
//
//  Created by Dimitris Poluzos on 19/3/26.
//

import Foundation
import Combine
import AVFoundation

class RecommendationViewModel : ObservableObject {
    
    @Published var quote: Quote?
    @Published var firstSong: Song?
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var show: Show?
    
    @Published var isPlaying = false
    
    var player: AVPlayer?
    
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
    
    var songDisplay: String {
        if isLoading {
            return "Loading..."
        } else if let song = firstSong {
            let title = song.trackName ?? "Unknown title"
            let artist = song.artistName ?? "Unknown artist"
            return "\(title)\n\n— \(artist)"
        } else {
            return errorMessage ?? "Something went wrong"
        }
    }
    
    func fetchSong(mood: Mood) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let result = try await networkClient.fetchSong(mood: mood)
            firstSong = result
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    func fetchShow(mood: Mood) async {
        
        do {
            let result = try await networkClient.fetchShow(mood: mood)
            show = result
        } catch {
            print(error)
        }
    }

    
    func fetchQuote(mood: Mood) async {
        isLoading = true
        errorMessage = nil
        
        print("API KEY:", Config.apiKey)
        
        do {
            let result = try await networkClient.fetchQuote(mood: mood)
            quote = result
        } catch {
            print(error)
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func playPreview() {
        guard let urlString = firstSong?.previewUrl,
              let url = URL(string: urlString) else { return }
        
        player = AVPlayer(url: url)
        player?.play()
    }
    func togglePlay() {
            guard let urlString = firstSong?.previewUrl,
                  let url = URL(string: urlString) else { return }
            
            if player == nil {
                player = AVPlayer(url: url)
            }
            
            if isPlaying {
                player?.pause()
            } else {
                player?.play()
            }
            
            isPlaying.toggle()
        }
    
}
