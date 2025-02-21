//
//  Gradient.swift
//  RainbowUI
//
//  Created by Volodymyr Boichentsov on 10/02/2025.
//

import SwiftUI

public extension Gradient {
    static var rainbow: Gradient {
        Gradient(colors: [
            .red,
            .red, .orange, .yellow, .green, .blue, .blue, .purple, .purple, .pink, .red,
            .red, .orange, .yellow, .green, .blue, .blue, .purple, .purple, .pink, .red,
            .red, .orange, .yellow, .green, .blue, .blue, .purple, .purple, .pink, .red,
        ])
    }
}


#Preview {
    LinearGradient(gradient: .rainbow, startPoint: .top, endPoint: .bottom)
        .frame(width: 200, height: 200)
        .scaleEffect(3)
        .clipShape(RoundedRectangle(cornerRadius: 20))
}
