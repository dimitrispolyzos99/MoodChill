//
//  ShowSection.swift
//  MoodChill
//
//  Created by Dimitris Poluzos on 27/3/26.
//

import SwiftUI

struct ShowSection: View {
    @ObservedObject var recommended: RecommendationViewModel
    
    let mood: Mood
    
    var body: some View {
        MediaCardView {
        if recommended.isShowLoading {
            SectionCardView(title: "Show", text: "Loading...")
        } else if let show = recommended.show {
            
            VStack(spacing: 12) {
                Text(show.name)
                    .font(.headline)
                    .foregroundColor(.white)
                
                if let imageUrl = show.image?.medium,
                   let url = URL(string: imageUrl) {
                    
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(height: 180)
                    .clipped()
                    .cornerRadius(16)
                    
                }
                if let summary = show.summary {
                    Text(summary.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression))
                        .font(.subheadline)
                        .opacity(0.8)
                        .lineLimit(3)
                        .foregroundColor(.white)
                }
            }
        }
        else if let showErrorMessage = recommended.showErrorMessage {
            SectionCardView(title: "Show", text: showErrorMessage)
            Button("Retry"){
                Task {
                    await recommended.fetchShow(mood: mood)
                }
            }
            
        }
    }
    }
}

#Preview {
    ShowSection(recommended: RecommendationViewModel(), mood: .Happy)
}
