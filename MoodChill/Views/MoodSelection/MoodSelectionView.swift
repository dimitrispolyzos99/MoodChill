//
//  ContentView.swift
//  MoodChill
//
//  Created by Dimitris Poluzos on 19/3/26.
//

import SwiftUI

struct MoodSelectionView: View {
    @StateObject private var moodSVM = MoodSelectionViewModel()
    @State private var selectedMood: Mood? = nil
    var body: some View {
        NavigationStack{
            ZStack {
                
                if let code = moodSVM.weather?.weatherCode {
                    Image(moodSVM.getBackgroundName(for: code))
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                        .animation(.easeInOut, value: moodSVM.weather?.weatherCode)
                } else {
                    Color(.systemBackground).ignoresSafeArea()
                }
                VStack {

                    VStack(spacing: Spacing.large) {
                        WeatherView(moodSVM: moodSVM)
                    }
                    
                    MoodCardView{
                    VStack(spacing: 12){

                            MoodGridView(selectedMood: $selectedMood)
                            ContinueButtonView(selectedMood: $selectedMood)
                        }
                    }
                }
            
            Spacer()
        }
        .task {
            await moodSVM.fetchWeather()
        }
        
    }
    }
}
#Preview {
    MoodSelectionView()
}

