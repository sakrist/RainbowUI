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
            .red, .orange, .yellow, .green, .blue, .purple, .pink,
            .red, .orange, .yellow, .green, .blue, .purple, .pink,
            .red, .orange, .yellow, .green, .blue, .purple, .pink
        ])
    }
}
