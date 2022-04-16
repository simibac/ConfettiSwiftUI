//
//  View+ConfettiCannon.swift
//  
//
//  Created by Abdullah Alhaider on 24/03/2022.
//

import SwiftUI

public extension View {
    
    /// renders configurable confetti animaiton
    ///
    /// - Usage:
    ///
    /// ```
    ///    import SwiftUI
    ///
    ///    struct ContentView: View {
    ///
    ///        @State private var counter: Int = 0
    ///
    ///        var body: some View {
    ///            Button("Wow") {
    ///                counter += 1
    ///            }
    ///            .confettiCannon(counter: $counter)
    ///        }
    ///    }
    /// ```
    ///
    /// - Parameters:
    ///   - counter: on any change of this variable the animation is run
    ///   - num: amount of confettis
    ///   - colors: list of colors that is applied to the default shapes
    ///   - confettiSize: size that confettis and emojis are scaled to
    ///   - rainHeight: vertical distance that confettis pass
    ///   - fadesOut: reduce opacity towards the end of the animation
    ///   - opacity: maximum opacity that is reached during the animation
    ///   - openingAngle: boundary that defines the opening angle in degrees
    ///   - closingAngle: boundary that defines the closing angle in degrees
    ///   - radius: explosion radius
    ///   - repetitions: number of repetitions of the explosion
    ///   - repetitionInterval: duration between the repetitions
    ///
    @ViewBuilder func confettiCannon(
        counter: Binding<Int>,
        num: Int = 20,
        confettis: [ConfettiType] = ConfettiType.allCases,
        colors: [Color] = [.blue, .red, .green, .yellow, .pink, .purple, .orange],
        confettiSize: CGFloat = 10.0,
        rainHeight: CGFloat = 600.0,
        fadesOut: Bool = true,
        opacity: Double = 1.0,
        openingAngle: Angle = .degrees(60),
        closingAngle: Angle = .degrees(120),
        radius: CGFloat = 300,
        repetitions: Int = 0,
        repetitionInterval: Double = 1.0
    ) -> some View {
        ZStack {
            self
            ConfettiCannon(
                counter: counter,
                num: num,
                confettis: confettis,
                colors: colors,
                confettiSize: confettiSize,
                rainHeight: rainHeight,
                fadesOut: fadesOut,
                opacity: opacity,
                openingAngle: openingAngle,
                closingAngle: closingAngle,
                radius: radius,
                repetitions: repetitions,
                repetitionInterval: repetitionInterval
            )
        }
    }
}
