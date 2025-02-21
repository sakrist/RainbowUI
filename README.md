
### Overview

RainbowButtonStyle is a custom ButtonStyle for SwiftUI that applies a visually striking, animated rainbow gradient background to buttons.
The gradient continuously animates in a circular motion, creating a glowing effect. 

### Code Example

```swift
import RainbowUI

Button {
    print("Button tapped!")
} label: {
    Text("Rainbow Button")
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
}
.font(.title)
.buttonStyle(RainbowButtonStyle())
```
<img width="209" alt="Screenshot 2025-02-21 at 18 38 40" src="https://github.com/user-attachments/assets/24367602-4aa9-41f6-8932-606132915b70" />


```swift
Text("Hello, rainbow run! ✨").rainbowRun()
```
<img width="244" alt="Screenshot 2025-02-21 at 18 39 17" src="https://github.com/user-attachments/assets/f26d68f5-4b42-4391-9d04-979c2c023bc3" />


```swift
Button {
        print("Button tapped!")
} label: {
    Text("Rainbow Border")
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
}
.rainbowBorder()
```
