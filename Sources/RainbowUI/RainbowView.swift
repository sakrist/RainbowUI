//
//  RainbowRun.swift
//  RainbowUI
//
//  Created by Volodymyr Boichentsov on 08/02/2025.
//


import SwiftUI
#if os(macOS)
import AppKit
#endif



public extension View {
    func rainbowRun(_ surface: Gradient = .rainbow) -> some View {
        return RainbowView(surface, content: self)
    }
}

internal struct RainbowView<Content>: View where Content: View {
    
    let startDate = Date()
    
    var content: Content
    var surface: Gradient
    
    init(_ surface: Gradient = .rainbow, content: Content) {
        self.surface = surface
        self.content = content
    }
    
    init(_ surface: Gradient = .rainbow, @ViewBuilder content: () -> Content) {
        self.surface = surface
        self.content = content()
    }
    
    func scale(_ proxy: GeometryProxy) -> CGFloat {
        #if os(iOS)
        return UIScreen.main.bounds.height / radius(proxy) * 2
        #elseif os(macOS)
        return (NSScreen.main?.frame.height ?? 1080) / radius(proxy) * 2
        #endif
    }
    
    func radius(_ proxy: GeometryProxy) -> CGFloat {
        return min(proxy.frame(in: .global).width / 2, proxy.frame(in: .global).height / 2)
    }
    
    
    var body: some View {
                    
        self.content
            .foregroundColor(.clear)
            .background( GeometryReader { (proxy) in
                TimelineView(.animation) { context in
                    ZStack {
                        let time = context.date.timeIntervalSinceReferenceDate
                        let cycleTime = 3.5
                        let x = time.truncatingRemainder(dividingBy: cycleTime)
                        let speed = 300.0
                        let offx = -((x < cycleTime/2.0) ? (x * speed) : ((cycleTime - x) * speed) ) - 100

                        RadialGradient(
                            gradient: self.surface,
                            center: .center,
                            startRadius: 0.3,
                            endRadius: self.radius(proxy))
                        .scaleEffect(self.scale(proxy))
                        .offset(.init(width: offx, height: 0))
                    }
                }
                .mask(self.content)
            })
        
    }
}

#Preview {
    Rectangle()
        .frame(width: 200, height: 50)
        .rainbowRun()
    
    Text("Hello, rainbow run! ✨").rainbowRun()
}
