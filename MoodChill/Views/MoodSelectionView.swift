//
//  ContentView.swift
//  MoodChill
//
//  Created by Dimitris Poluzos on 19/3/26.
//

import SwiftUI

struct MoodSelectionView: View {
    @StateObject private var moodSVM = MoodSelectionViewModel()
    @State private var selectedMood: Mood?
    var body: some View {
        NavigationStack{
            ZStack {
                
                if let code = moodSVM.weather?.weatherCode {
                    Image(moodSVM.getBackgroundName(for: code))
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                } else {
                    Color.blue.ignoresSafeArea()
                }
                VStack {
                    
                    
                    VStack(spacing: 10) {
                        if let weather = moodSVM.weather {
                            Text("Athens Greece \n Today's weather: \(weather.temp_C)°C \(Image(systemName: moodSVM.getWeatherIcon(for: weather.weatherCode)))")
                                .symbolRenderingMode(.multicolor)
                                .font(.system(size: 20, weight: .bold))
                                .padding()
                                .background(.ultraThinMaterial)
                                .cornerRadius(20)
                            
                            VStack{
                            Text("Mood selection")
                                .font(.largeTitle)
                                .bold()
                                .padding()
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

                            Text("Selected mood: \(selectedMood?.title ?? "None")")
                                    .font(.system(size: 20, weight: .bold))
                        }
                                .padding(.vertical, 25)
                                .padding(.horizontal, 15)
                                .background(.ultraThinMaterial)
                                .cornerRadius(25)
                        }
                    }
                    Spacer()
                    .task {
                        await moodSVM.fetchWeather()
                    }
                }
            }
        }
    }
}
#Preview {
    MoodSelectionView()
}

