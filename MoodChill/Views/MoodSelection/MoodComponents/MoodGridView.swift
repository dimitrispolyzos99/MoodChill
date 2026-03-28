//
//  MoodGridView.swift
//  MoodChill
//
//  Created by Dimitris Poluzos on 28/3/26.
//

import SwiftUI

struct MoodGridView: View {
    @Binding var selectedMood: Mood?
    var body: some View {
        VStack(spacing: 12){
            Text("Mood selection")
                .font(.largeTitle)
                .bold()
                .padding()
            LazyVGrid(
                columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                ],
                spacing: 12){
                    ForEach(Mood.allCases, id: \.self) { mood in
                        MoodButton(mood: mood, isSelected: selectedMood == mood, action: {
                            selectedMood = mood
                        })
                    }
                }
        }
    }
}

#Preview {
    MoodGridView(selectedMood: .constant(nil))
}
