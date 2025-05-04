//
//  RainbowBorder.swift
//  RainbowUI
//
//  Created by Volodymyr Boichentsov on 21/02/2025.
//

import SwiftUI
internal struct RainbowBorderModifier: ViewModifier {
    let startDate = Date()
    private let shaderlibrary = RainbowHelper.shared.shaderlibrary

    var cornerRadius: CGFloat
    var borderWidth: CGFloat

    func body(content: Content) -> some View {
        content
            .overlay(
                TimelineView(.animation) { context in
                    GeometryReader { proxy in
                        let size = proxy.size
                        let mask = RoundedRectangle(cornerRadius: cornerRadius)
                            .strokeBorder(lineWidth: borderWidth)
                        
                        mask
                            .visualEffect { content, _ in
                                content.layerEffect(
                                    shaderlibrary.rainbowCircle(
                                        .float(startDate.timeIntervalSinceNow),
                                        .float2(size)
                                    ),
                                    maxSampleOffset: .zero
                                )
                            }
                            .mask(mask)
                    }
                }
            )
    }
}

extension View {
    func rainbowBorder(cornerRadius: CGFloat = 10, borderWidth: CGFloat = 2) -> some View {
        self.modifier(RainbowBorderModifier(cornerRadius: cornerRadius, borderWidth: borderWidth))
    }
}


#Preview {
    Button {
        print("Button tapped!")
       
    } label: {
        Text("Rainbow Border")
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
    }
    .rainbowBorder()
        
}
