//
//  ContentView.swift
//  MoodChill
//
//  Created by Dimitris Poluzos on 19/3/26.
//

import SwiftUI

struct MoodSelectionView: View {
    @State private var selectedMood: Mood?
    var body: some View {
        NavigationStack{
                VStack {
                    Text("Mood selection")
                    
                    HStack(spacing: 3) {
                        
                        ForEach(Mood.allCases, id: \.self) { mood in
                            NavigationLink(destination: RecommendationView(mood: mood)) {
                                VStack(spacing: 5){
                                    Text(mood.title)
                                    Text(mood.symbol)
                                }
                                .foregroundColor(.white)
                                .shadow(radius: 6)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background((selectedMood == mood) ? Color(mood.color) : Color.orange)
                                .cornerRadius(10)
                            }
                            .simultaneousGesture(TapGesture().onEnded {
                                selectedMood = mood
                            })
                        }
                    }
                    .frame(maxWidth: .infinity)
                    Text("Selected mood: \(selectedMood?.title ?? "None")")
                }
            }
        }
    }


#Preview {
    MoodSelectionView()
}

