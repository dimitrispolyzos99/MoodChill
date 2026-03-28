//
//  MoodButtons.swift
//  MoodChill
//
//  Created by Dimitris Poluzos on 28/3/26.
//

import SwiftUI

struct MoodButton: View {
    
    let mood: Mood
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        
        Button {
            action()
        } label: {
            VStack(spacing: 8){
                Text(mood.symbol)
                    .font(.largeTitle)
                Text(mood.title)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                ZStack{
                    RoundedRectangle(cornerRadius: 16)
                        .fill(isSelected ? Color(mood.color) : Color(mood.color).opacity(0.2))
                    
                    if isSelected {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.white, lineWidth: 2)
                    }
                }
            )
            .scaleEffect(isSelected ? 1.05 : 1.0)
            .animation(.easeInOut(duration: 0.2), value: isSelected)
        }
        
    }
}

#Preview {
    MoodButton(mood: .Sad, isSelected: true) {
        
    }
}
