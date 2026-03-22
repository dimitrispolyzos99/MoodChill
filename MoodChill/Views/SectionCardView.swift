//
//  SectionCardView.swift
//  MoodChill
//
//  Created by Dimitris Poluzos on 20/3/26.
//

import SwiftUI

struct SectionCardView: View {
    let title: String
    let text: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.title)
            Text(text)
                .padding()
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.black.opacity(0.7)))
                .cornerRadius(30)
                .shadow(radius: 4)
        }
    }
}
#Preview {
    SectionCardView(title: "Title", text: "Coming soon")
}
