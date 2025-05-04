//
//  RainbowButtonStyle.swift
//
//  Created by Volodymyr Boichentsov on 19/01/2025.
//

import SwiftUI

public struct RainbowButtonStyle: ButtonStyle {
    let startDate = Date()
    public init() {}
    
    private let shaderlibrary = ShaderLibrary.bundle(Bundle.module)
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(
                ZStack {
                    TimelineView(.animation) { context in
                        Rectangle()
                            .visualEffect { content, proxy in
                                content.layerEffect(shaderlibrary.rainbowCircle(.float(startDate.timeIntervalSinceNow), .float2(proxy.size)),
                                                    maxSampleOffset: .zero)
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    
                    RoundedRectangle(cornerRadius: 8)
                    #if os(iOS)
                        .fill(Color(.systemBackground))
                    #elseif os(macOS)
                        .fill(Color(.windowBackgroundColor))
                    #endif
                        .padding(2)
                }
            )
            .foregroundColor(.primary)
            .shadow(
                color: Color.purple.opacity(0.5), // Single glowing shadow
                radius: 10,
                x: 0,
                y: 0
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.spring(), value: configuration.isPressed)
            
    }
}



#Preview {
    ZStack {
        Button {
            print("Button tapped!")
            guard let device = try? MTLCreateSystemDefaultDevice() else {
                fatalError("Unable to create default device")
            }
            guard let library = try? device.makeDefaultLibrary(bundle: Bundle.module)
                  else { fatalError("Unable to create default library") }
            
            let library2 = ShaderLibrary.bundle(Bundle.module)
                  
            print(library)
            
            print(library2.rainbow)
        } label: {
            Text("Rainbow Button")
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
        }
        .font(.title)
        .buttonStyle(RainbowButtonStyle())
//        .rainbowBorder()
    }
}

