//
//  MediaCardView.swift
//  MoodChill
//
//  Created by Dimitris Poluzos on 27/3/26.
//

import SwiftUI

struct MediaCardView<Content: View>: View {
    let content: Content
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    var body: some View {
        content
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.black.opacity(0.7))
            )
            .shadow(radius: 4)
    }
}

#Preview {
    MediaCardView {
        
    }
}
