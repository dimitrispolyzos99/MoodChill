//
//  MiniPlayerView.swift
//  MoodChill
//
//  Created by Dimitris Poluzos on 27/3/26.
//

import SwiftUI

struct MiniPlayerView: View {
    @ObservedObject var recommended: RecommendationViewModel
    var body: some View {
        if let song = recommended.firstSong,
        let previewUrl = song.previewUrl,
               !previewUrl.isEmpty {
                
                VStack {
                    Spacer()
                    
                    HStack {
                        VStack(alignment: .leading){
                            Text(song.trackName ?? "Unknown")
                                .font(.headline)
                            
                            Text(song.artistName ?? "Unknown")
                                .font(.subheadline)
                                .opacity(0.7)
                        }
                        
                        Spacer()
                        
                        Button {
                            recommended.togglePlay()
                        } label: {
                            Image(systemName: recommended.isPlaying ? "pause.fill" : "play.fill")
                                .font(.title2)
                                .padding()
                                .background(Color.white)
                                .clipShape(Circle())
                        }
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(20)
                    .padding()
                }
            }

    }
}

#Preview {
    MiniPlayerView(recommended: RecommendationViewModel())
}
