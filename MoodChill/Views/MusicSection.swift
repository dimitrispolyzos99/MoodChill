//
//  MusicSection.swift
//  MoodChill
//
//  Created by Dimitris Poluzos on 27/3/26.
//

import SwiftUI

struct MusicSection: View {
    @ObservedObject var recommended: RecommendationViewModel
    
    let mood: Mood
    
    var body: some View {
        MediaCardView{
            if recommended.isSongLoading {
                SectionCardView(title: "Music", text: "Loading...")
            } else if let song = recommended.firstSong {
                VStack(spacing: Spacing.medium) {
                    
                    Text(song.trackName ?? "Unknown")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    if let imageUrl = song.artworkUrl100 {
                        let highRes = imageUrl.replacingOccurrences(of: "100x100", with: "600x600")
                        
                        if let url = URL(string: highRes) {
                            AsyncImage(url: url) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(height: 180)
                            .clipped()
                            .cornerRadius(16)
                        }
                    }
                    
                    Text(song.artistName ?? "Unknown")
                        .font(.subheadline)
                        .opacity(0.7)
                        .foregroundColor(.white)
                }
            } else if let songErrorMessage = recommended.songErrorMessage {
                SectionCardView(title: "Music", text: songErrorMessage)
                
                Button("Retry"){
                    Task {
                        await recommended.fetchSong(mood: mood)
                    }
                }
            } else {
                SectionCardView(title: "Music", text: "No recommendation available")
            }
        }
    }
}

#Preview {
    ShowSection(recommended: RecommendationViewModel(), mood: .Happy)
}


