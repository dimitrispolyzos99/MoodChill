//
//  RecommendationViewModel.swift
//  MoodChill
//
//  Created by Dimitris Poluzos on 19/3/26.
//

import Foundation
import Combine
import AVFoundation

@MainActor
class RecommendationViewModel: ObservableObject {
    
    @Published var quote: Quote?
    @Published var firstSong: Song?
    @Published var isSongLoading = false
    @Published var isQuoteLoading = false
    @Published var isShowLoading = false
    @Published var songErrorMessage: String?
    @Published var quoteErrorMessage: String?
    @Published var showErrorMessage: String?
    @Published var show: Show?
    
    @Published var isPlaying = false
    
    var player: AVPlayer?
    
    var hasPreview: Bool {
        if let previewUrl = firstSong?.previewUrl {
            return !previewUrl.isEmpty
        }
        return false
    }
    
    let networkClient = NetworkClient()
    
    func loadContent(for mood:Mood) async {
        quoteErrorMessage = nil
        songErrorMessage = nil
        showErrorMessage = nil
        await fetchQuote(mood: mood)
        await fetchSong(mood: mood)
        await fetchShow(mood: mood)
    }

    
    var quoteDisplayText: String {
        if let quote = quote {
            "\"\(quote.quote)\"\n\n- \(quote.author)"
        } else {
            quoteErrorMessage ?? "Could not load quotes"
        }
    }
    
    func fetchSong(mood: Mood) async {
        isSongLoading = true
        songErrorMessage = nil
        
        defer {
            isSongLoading = false
        }
        
        do {
            let result = try await networkClient.fetchSong(mood: mood)
            firstSong = result
            print("New song", result.trackName ?? "nil")
        } catch {
            if let urlError = error as? URLError, urlError.code == .cancelled {
                return
            }
            
            songErrorMessage = error.localizedDescription
        }
    }
    func fetchShow(mood: Mood) async {
        isShowLoading = true
        showErrorMessage = nil
        
        defer {
            isShowLoading = false
        }
        
        do {
            let result = try await networkClient.fetchShow(mood: mood)
            show = result
            print("New show", result.name)
        } catch {
            if let urlError = error as? URLError, urlError.code == .cancelled {
                return
            }
            showErrorMessage = error.localizedDescription
        }
    }

    
    func fetchQuote(mood: Mood) async {
        isQuoteLoading = true
        quoteErrorMessage = nil
        
        defer {
            isQuoteLoading = false
        }
        
        do {
            let result = try await networkClient.fetchQuote(mood: mood)
            quote = result
            print("New Quote", result.quote)
        } catch {
            if let urlError = error as? URLError, urlError.code == .cancelled {
                return
            }
            quoteErrorMessage = error.localizedDescription
        }
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
