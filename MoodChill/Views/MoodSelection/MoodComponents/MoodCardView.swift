//
//  MoodCardView.swift
//  MoodChill
//
//  Created by Dimitris Poluzos on 28/3/26.
//

import SwiftUI

struct MoodCardView<Content: View>: View {
    let content: Content
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    var body: some View {
        content
            .frame(width: 360)
            .padding(.vertical, 18)
            .padding(.horizontal, 15)
            .background(.ultraThinMaterial)
            .cornerRadius(20)
    }
}

#Preview {
    MediaCardView {
        
    }
}
