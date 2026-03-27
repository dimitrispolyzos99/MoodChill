//
//  MoodHeader.swift
//  MoodChill
//
//  Created by Dimitris Poluzos on 27/3/26.
//

import SwiftUI

struct MoodHeader: View {
    let mood: Mood
    var body: some View {
        VStack(spacing: 8) {
            Text("Today's Mood")
                .font(.subheadline)
                .opacity(0.8)
            
            Text(mood.title)
                .font(.largeTitle)
                .fontWeight(.bold)
        }
        .padding(.bottom, 10)
    }
}

#Preview {
    MoodHeader(mood: .Happy)
}
