//
//  QuoteSection.swift
//  MoodChill
//
//  Created by Dimitris Poluzos on 27/3/26.
//

import SwiftUI

struct QuoteSection: View {
    @ObservedObject var recommended: RecommendationViewModel
    let mood: Mood
    var body: some View {
        if recommended.isQuoteLoading{
            SectionCardView(title: "Quote", text: "Loading...")
        } else if recommended.quote != nil {
            SectionCardView(
                title: "Quote",
                text: recommended.quoteDisplayText)
        } else if recommended.quoteErrorMessage != nil  {
            SectionCardView(title: "Quote", text: recommended.quoteErrorMessage!)
            Button("Retry"){
                Task {
                    await recommended.fetchQuote(mood: mood)
                }
            }

        } else {
            SectionCardView(title: "Quote", text: "No quote available")
        }
    }
}

#Preview {
    QuoteSection(recommended: RecommendationViewModel(), mood: .Happy)
}
