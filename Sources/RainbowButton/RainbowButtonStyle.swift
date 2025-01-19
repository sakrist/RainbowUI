//
//  RainbowButtonStyle.swift
//
//  Created by Volodymyr Boichentsov on 19/01/2025.
//

import SwiftUI

public struct RainbowButtonStyle: ButtonStyle {
    @State private var angle: Double = 0
    
    public init() {}
    
    let rainbowColors: [Color] = [.red, .orange, .yellow, .green, .blue, .purple, .red]
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(
                            AngularGradient(
                                gradient: Gradient(colors: rainbowColors),
                                center: .center,
                                angle: .degrees(angle)
                            )
                        )
                    
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(.systemBackground))
                        .padding(2)
                }
            )
            .foregroundColor(.primary)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(
                        AngularGradient(
                            gradient: Gradient(colors: rainbowColors),
                            center: .center,
                            angle: .degrees(angle)
                        ),
                        lineWidth: 2
                    )
            )
            // Multiple layered shadows with different colors and offsets
            .shadow(
                color: Color.purple.opacity(0.5), // Single glowing shadow
                radius: 10,
                x: 0,
                y: 0
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.spring(), value: configuration.isPressed)
            .onAppear {
                withAnimation(.linear(duration: 3)
                    .repeatForever(autoreverses: false)) {
                    angle = 360
                }
            }
    }
}



#Preview {
    ZStack {
        Button("Rainbow Button") {
            print("Button tapped!")
        }
        .font(.title)
        .buttonStyle(RainbowButtonStyle())
    }
}

