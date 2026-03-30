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
                
                if let weather = moodSVM.weather {
                    Image(moodSVM.getBackgroundName(for: weather.weathercode, isDay: weather.is_day == 1))
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
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
            moodSVM.requestLocation()
            await moodSVM.fetchWeatherForCurrentLocation()
        }
        
    }
    }
}
#Preview {
    MoodSelectionView()
}

