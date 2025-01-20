//
//  RainbowButtonStyle.swift
//
//  Created by Volodymyr Boichentsov on 19/01/2025.
//

import SwiftUI


struct RotatingEffect: ViewModifier {
    @Binding var angle: Double
    let duration: Double

    func body(content: Content) -> some View {
        content
            .onAppear {
                withAnimation(.linear(duration: duration).repeatForever(autoreverses: false)) {
                    angle = 360
                }
            }
    }
}

extension View {
    func rotatingEffect(angle: Binding<Double>, duration: Double) -> some View {
        self.modifier(RotatingEffect(angle: angle, duration: duration))
    }
}

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
            .rotatingEffect(angle: $angle, duration: 3)
            
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

