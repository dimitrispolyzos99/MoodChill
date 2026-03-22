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


        ZStack{
            Color(mood.color)
                .ignoresSafeArea()
            ScrollView {
                VStack(spacing: 40) {
                    VStack(spacing: 8) {
                        Text("Today's Mood")
                            .font(.subheadline)
                            .opacity(0.8)
                        
                        Text(mood.title)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }
                    .padding(.bottom, 10)
                    VStack(spacing: 30){
                        SectionCardView(title: "Music", text: "Coming soon")
                        
                        SectionCardView(
                                title: "Quote",
                                text: recomended.quoteDisplayText
                        )
                        
                        SectionCardView(title: "Show", text: "Coming soon")
                        
                        SectionCardView(title: "Game", text: "Coming soon")
                    }
                }
                .padding()
            }
            .task {
                await recomended.fetchQuote()
            }
        }
    }
}

#Preview {
    RecommendationView(mood: .Happy)
}
