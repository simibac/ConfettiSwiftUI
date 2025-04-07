# ConfettiSwiftUI

![GitHub License](https://img.shields.io/github/license/simibac/ConfettiSwiftUI?logo=github)
![Cocoapods platforms](https://img.shields.io/cocoapods/p/AFNetworking?logo=apple)


<p align="center">
  <img src="./Gifs/native_default_iphone.png" width="200" width="480"/>
</p>

Customize confetti animations.

- All elements are built with pure SwiftUI.
- Select from default confetti shapes, emojis, SF Symbols or text.
- Trigger the animation with one state change multiple times with a haptic feed back on each explosion.


## 🌄 Examples

<p align="center">
  <img src="./Gifs/default.gif" width="150" />
  <img src="./Gifs/make-it-rain.gif" width="150"/>
  <img src="./Gifs/explosion.gif" width="150" />
  <img src="./Gifs/color.gif" width="150" />
</p>

## 💻 Installation

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for managing the distribution of Swift code. It’s integrated with the Swift build system to automate the process of downloading, compiling, and linking dependencies.

To integrate `ConfettiSwiftUI` into your Xcode project using Xcode 12, specify it in `File > Swift Packages > Add Package Dependency...`:

```ogdl
https://github.com/simibac/ConfettiSwiftUI.git, :branch="master"
```

---

### Manually

If you prefer not to use any of dependency managers, you can integrate `ConfettiSwiftUI` into your project manually. Put `Sources/ConfettiSwiftUI` folder in your Xcode project. Make sure to enable `Copy items if needed` and `Create groups`.

## 🧳 Requirements

- iOS 14.0+ | macOS 11+
- Swift 5+

## 🛠 Usage

First, add `import ConfettiSwiftUI` on every `swift` file you would like to use `ConfettiSwiftUI`. Define a integer as a state varable which is responsible for triggering the animation. Any change to that variable will span a new animation (increment and decrement).

```swift
import ConfettiSwiftUI
import SwiftUI

struct ContentView: View {
    
    @State private var trigger: Int = 0
    
    var body: some View {
        Button("🎉") {
            trigger += 1
        }
        .confettiCannon(trigger: $trigger)
    }
}

```

### Parameters

| parameter          | type           | description                                           | default                                                                                              |
| ------------------ | -------------- | ----------------------------------------------------- | ---------------------------------------------------------------------------------------------------- |
| trigger            | Binding<Int>   | on any change of this variable triggers the animation | 0                                                                                                    |
| num                | Int            | amount of confettis                                   | 20                                                                                                   |
| confettis          | [ConfettiType] | list of shapes and text                               | [.shape(.circle), .shape(.triangle), .shape(.square), .shape(.slimRectangle), .shape(.roundedCross)] |
| colors             | [Color]        | list of colors applied to the default shapes          | [.blue, .red, .green, .yellow, .pink, .purple, .orange]                                              |
| confettiSize       | CGFloat        | size that confettis and emojis are scaled to          | 10.0                                                                                                 |
| rainHeight         | CGFloat        | vertical distance that confettis pass                 | 600.0                                                                                                |
| fadesOut           | Bool           | size that confettis and emojis are scaled to          | true                                                                                                 |
| opacity            | Double         | maximum opacity during the animation                  | 1.0                                                                                                  |
| openingAngle       | Angle          | boundary that defines the opening angle in degrees    | Angle.degrees(60)                                                                                    |
| closingAngle       | Angle          | boundary that defines the closing angle in degrees    | Angle.degrees(120)                                                                                   |
| radius             | CGFloat        | explosion radius                                      | 300.0                                                                                                |
| repetitions        | Int            | number of repetitions for the explosion               | 1                                                                                                    |
| repetitionInterval | Double         | duration between the repetitions                      | 1.0                                                                                                  |
| hapticFeedback | Bool         | haptic feedback on each confetti explosion                      | true                                                                                                  |

### Configurator Application With Live Preview

You can use the configurator app in [demo project here](https://github.com/simibac/ConfettiSwiftUIDemo) to configure your desired animation or get inspired by one of the many examples.
  
<p align="center">
   <img src="./Gifs/configurator.png" width="150" />
   <img src="./Gifs/examples.png" width="150" />
 </p>

### Configuration Examples

#### Color and Size

<p align="center">
  <img src="./Gifs/color.gif" width="150" />
</p>

```swift
.confettiCannon(trigger: $trigger, colors: [.red, .black], confettiSize: 20)
```

#### Repeat

<p align="center">
  <img src="./Gifs/repeat.gif" width="150" />
</p>

```swift
.confettiCannon(trigger: $trigger, repetitions: 3, repetitionInterval: 0.7)
```

#### Firework

<p align="center">
  <img src="./Gifs/explosion.gif" width="150" />
</p>

```swift
.confettiCannon(trigger: $trigger, num: 50, openingAngle: Angle(degrees: 0), closingAngle: Angle(degrees: 360), radius: 200)
```

#### Emoji

<p align="center">
  <img src="./Gifs/heart.gif" width="150" />
</p>

```swift
.confettiCannon(trigger: $trigger, confettis: [.text("❤️"), .text("💙"), .text("💚"), .text("🧡")])
```

#### Endless

<p align="center">
  <img src="./Gifs/constant.gif" width="150" />
</p>

```swift
.confettiCannon(trigger: $trigger, num:1, confettis: [.text("💩")], confettiSize: 20, repetitions: 100, repetitionInterval: 0.1)
```

#### Make-it-Rain

<p align="center">
  <img src="./Gifs/make-it-rain.gif" width="150" />
</p>

```swift
.confettiCannon(trigger: $trigger, num:1, confettis: [.text("💵"), .text("💶"), .text("💷"), .text("💴")], confettiSize: 30, repetitions: 50, repetitionInterval: 0.1)
```



<p align="center">
  <img src="https://github.com/simibac/ConfettiSwiftUI/assets/15369592/c4c7c28a-c8cc-4d17-bd5c-240ce5cb4dcb" width="150" />
</p>

```swift
.confettiCannon(trigger: $trigger8, confettis: [.image("arb"), .image("eth"), .image("btc"), .image("op"), .image("link"), .image("doge")], confettiSize: 20)
```

## 👨‍💻 Contributors

All issue reports, feature requests, pull requests and GitHub stars are welcomed and much appreciated.

## 🔨Support 

If you like the project, don't forget to `put star 🌟`.

 <a href="https://www.buymeacoffee.com/nwbbfqmp7qd" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" style="height: 60px !important;width: 217px !important;" ></a>

<!-- <a href="mailto:simibac2@icloud.com"><img src="https://img.shields.io/badge/EMAIL-SIMON-informational?style=for-the-badge&logo=minutemailer&logoColor=white"></a>&nbsp;&nbsp;&nbsp;<a href="https://www.linkedin.com/in/simon-bachmann-73b695151/" target="_blank"><img src="https://img.shields.io/badge/LINKEDIN-informational?style=for-the-badge&logo=linkedin&logoColor=white" ></a>&nbsp;&nbsp;&nbsp;<a href="https://www.paypal.com/donate?business=6H8D2EDR6LBX6&no_recurring=0&item_name=Thanks+for+supporting+open+source+contributions%21&currency_code=CHF" target="_blank"><img src="https://img.shields.io/badge/Donate-informational?style=for-the-badge&logo=paypal&logoColor=white" ></a> -->

## 📃 License

`ConfettiSwiftUI` is available under the MIT license. See the [LICENSE](https://github.com/simibac/ConfettiSwiftUI/blob/master/LICENSE) file for more info.

## 📦 Projects

The following projects have integrated ConfettiSwiftUI in their App.

- [Basic Code](https://basiccode.de) available on the [AppStore](https://apps.apple.com/de/app/basiccode/id1562309250)
- [AnyTracker](https://anytracker.org/) available on the [AppStore](https://apps.apple.com/app/anytracker-track-anything/id6450756953)
- [Deep Dish Unofficial](https://github.com/MortenGregersen/DeepDishLie) available on the [AppStore](https://apps.apple.com/app/deep-dish-unofficial/id6448354703)

---

- [Jump Up](#-overview)
