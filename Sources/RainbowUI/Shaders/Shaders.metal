//
//  Shaders.metal
//  RainbowUI
//
//  Created by Volodymyr Boichentsov on 06/02/2025.
//

#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>
using namespace metal;

[[ stitchable ]] half4 rainbowCircle(float2 position, SwiftUI::Layer layer, float time, float2 size) {
    
    const float pi2 = 2.0 * M_PI_F;
    
    float2 center = float2(size.x/2.0, size.y/2.0);
    float2 pos = position - center;
    
    float angle = time * pi2; // 2 pi for full circle
    
    // rot matrix,
    float cosA = cos(angle);
    float sinA = sin(angle);
    float2 rotatedPos = float2(
        pos.x * cosA - pos.y * sinA,
        pos.x * sinA + pos.y * cosA
    );

    float rotatedAngle = atan2(rotatedPos.y, rotatedPos.x) / pi2 + 0.5;
    float shift = rotatedAngle * pi2;

    half3 color = half3(
        sin(shift) * 0.5 + 0.5,
        sin(shift + 2.094) * 0.5 + 0.5,
        sin(shift + 4.188) * 0.5 + 0.5
    );

    return half4(color, 1.0);
}
