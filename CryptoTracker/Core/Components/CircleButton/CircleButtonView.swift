//
//  CircleButtonView.swift
//  CryptoApplication
//
//  Created by Sameer  on 15/07/25.
//

import SwiftUI

struct CircleButtonView: View {
    
    let iconName: String
    
    var body: some View {
        Image(systemName: iconName)
            .font(.headline)
            .foregroundStyle(Color.theme.accent)
            .frame(width: 50, height: 50)
            .background(
                Circle()
                    .foregroundStyle(Color.theme.background)
            )
            .shadow(color: Color.theme.accent.opacity(0.25),
                    radius: 10,
                    x: 0, y: 0)
    }
}

#Preview {
    CircleButtonView(iconName: "heart.fill")
}
