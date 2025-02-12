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
    
    func bezierBlend(_ t:Double) -> Double {
        return t * t * (3.0 - 2.0 * t)
    }
    
    var body: some View {
                    
        self.content
            .foregroundColor(.clear)
            .background( GeometryReader { (proxy) in
                TimelineView(.animation) { context in
                    ZStack {
                        let time = context.date.timeIntervalSinceReferenceDate
                        let cycleTime = 4.0
                        let x = time.truncatingRemainder(dividingBy: cycleTime)
                        let a = bezierBlend(x / cycleTime)
                        
                        let speed = 1000.0
                        let offx = -((a < 0.5) ? (a * speed) : ((1.0 - a) * speed))

                        RadialGradient(
                            gradient: self.surface,
                            center: .center,
                            startRadius: 0.3,
                            endRadius: self.radius(proxy))
                        .scaleEffect(self.scale(proxy))
                        .offset(.init(width: offx, height: offx))
                    }
                }
                .mask(self.content)
            })
        
    }
}

#Preview {
    Rectangle()
        .frame(width: 300, height: 50)
        .rainbowRun()
    
    Text("Hello, rainbow run! ✨").rainbowRun()
}
