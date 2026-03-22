//
//  RecommendationView.swift
//  MoodChill
//
//  Created by Dimitris Poluzos on 19/3/26.
//

import SwiftUI

struct RecommendationView: View {
    
    @StateObject private var recomended = RecommendationViewModel()
    let mood: Mood
    
    var body: some View {
        
        ZStack {
            Color(mood.color)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    

                    VStack(spacing: 8) {
                        Text("Today's Mood")
                            .font(.subheadline)
                            .opacity(0.8)
                        
                        Text(mood.title)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }
                    .padding(.bottom, 10)
                    
                    VStack(spacing: 30) {
                        SectionCardView(
                            title: "Quote",
                            text: recomended.quoteDisplayText
                        )
                        
                        if let song = recomended.firstSong,
                           let imageUrl = song.artworkUrl100 {
                            
                            let highRes = imageUrl.replacingOccurrences(of: "100x100", with: "600x600")
                            
                            if let url = URL(string: highRes) {
                                
                                VStack(spacing: 12) {
                                    
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
                                    
                                    Text(song.trackName ?? "Unknown")
                                        .font(.headline)
                                    
                                    Text(song.artistName ?? "Unknown")
                                        .font(.subheadline)
                                        .opacity(0.7)
                                }
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(Color.black.opacity(0.7))
                                )
                            }
                        }

                        SectionCardView(title: "Show", text: "Coming soon")
                        SectionCardView(title: "Game", text: "Coming soon")
                    }
                }
                .padding()
                .padding(.bottom, recomended.firstSong != nil ? 100 : 0)
            }
            

            if let song = recomended.firstSong {
                VStack {
                    Spacer()
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text(song.trackName ?? "Unknown")
                                .font(.headline)
                            
                            Text(song.artistName ?? "")
                                .font(.subheadline)
                                .opacity(0.7)
                        }
                        
                        Spacer()
                        
                        Button {
                            recomended.togglePlay()
                        } label: {
                            Image(systemName: recomended.isPlaying ? "pause.fill" : "play.fill")
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
        .task {
            await recomended.fetchQuote(mood: mood)
            await recomended.fetchSong(mood: mood)
        }
    }
}

#Preview {
    RecommendationView(mood: .Happy)
}
#Preview {
    RecommendationView(mood: .Happy)
}

