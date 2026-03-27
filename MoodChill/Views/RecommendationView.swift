//
//  RecommendationView.swift
//  MoodChill
//
//  Created by Dimitris Poluzos on 19/3/26.
//

import SwiftUI

struct RecommendationView: View {
    
    @StateObject private var recommended = RecommendationViewModel()
    let mood: Mood
    
    var body: some View {
        
        ZStack {
            Color(mood.color)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: Spacing.medium) {
                    
            MoodHeader(mood: mood)
                    
                    VStack(spacing: Spacing.large) {
                
            QuoteSection(recommended: recommended,mood: mood)
                        
            MusicSection(recommended: recommended, mood: mood)

            ShowSection(recommended: recommended, mood: mood)
                        
                    }
                }
                .padding()
                .padding(.bottom, recommended.hasPreview ? 100 : 0)
            }
            .refreshable {
                await recommended.loadContent(for: mood)
            }
            
            MiniPlayerView(recommended: recommended)
            
            }
        
        .task {
            await recommended.loadContent(for: mood)
        }
    }
}

#Preview {
    RecommendationView(mood: .Happy)
}


