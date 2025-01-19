//
//  RainbowButtonStyle.swift
//
//  Created by Volodymyr Boichentsov on 19/01/2025.
//

import SwiftUI

public struct RainbowButtonStyle: ButtonStyle {
    @State private var angle: Double = 0
    @State private var timer: Timer?
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
                    #if os(iOS)
                        .fill(Color(.systemBackground))
                    #elseif os(macOS)
                        .fill(Color(.windowBackgroundColor))
                    #endif
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
            .shadow(
                color: Color.purple.opacity(0.5), // Single glowing shadow
                radius: 10,
                x: 0,
                y: 0
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.spring(), value: configuration.isPressed)
            .onAppear {
                // Start the timer to rotate the angle continuously
                timer = Timer.scheduledTimer(withTimeInterval: 0.01667, repeats: true) { _ in
                    DispatchQueue.main.async {
                        angle = (angle + 2).truncatingRemainder(dividingBy: 360)
                    }
                }
            }
            .onDisappear {
                // Invalidate the timer when the button disappears
                timer?.invalidate()
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

