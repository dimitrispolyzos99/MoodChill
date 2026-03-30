//
//  WeatherView.swift
//  MoodChill
//
//  Created by Dimitris Poluzos on 28/3/26.
//

import SwiftUI


struct WeatherView: View {
    @ObservedObject var moodSVM: MoodSelectionViewModel
    

    
    private var weatherText: String {
        if let weather = moodSVM.weather {
            return "Today's weather: \(Int(weather.temperature))°C"
        } else {
            return "Fetching weather..."
        }
    }
    
    private var weatherIconName: String? {
        if let weather = moodSVM.weather {
            return moodSVM.getWeatherIcon(for: weather.weathercode, isDay: weather.is_day == 1)
        }
        return nil
    }
    
    var body: some View {
        MoodCardView{
            HStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(moodSVM.locationManager.cityName)
                        .font(.headline)
                    
                    Text(weatherText)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                
                Spacer()
                
                if let weatherIconName {
                    Image(systemName: weatherIconName)
                        .symbolRenderingMode(.multicolor)
                        .imageScale(.large)
                } else {
                    ProgressView()
                }
            }
            .padding()
        }
    }
}

#Preview {
    WeatherView(moodSVM: MoodSelectionViewModel())
}
