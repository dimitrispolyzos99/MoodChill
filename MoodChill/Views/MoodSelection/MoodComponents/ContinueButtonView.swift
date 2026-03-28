//
//  ContinueView.swift
//  MoodChill
//
//  Created by Dimitris Poluzos on 28/3/26.
//

import SwiftUI

struct ContinueButtonView: View {
    @Binding var selectedMood: Mood?
    var body: some View {
        
        Text("Selected mood: \(selectedMood?.title ?? "None")")
            .font(.system(size: 20, weight: .bold))
            .padding()
        if let selectedMood {
            NavigationLink(destination: RecommendationView(mood: selectedMood)) {
                Text("Continue")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                .background(Color(selectedMood.color))
                    .cornerRadius(14)
            }
        }
    }
}

#Preview {
    ContinueButtonView(selectedMood: .constant(nil))
}
