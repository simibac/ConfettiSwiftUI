//
//  ConfettiView.swift
//  Confetti
//
//  Created by Simon Bachmann on 24.11.20.
//

import SwiftUI

public enum ConfettiType:CaseIterable, Hashable {
    
    public enum Shape {
        case circle
        case triangle
        case square
        case slimRectangle
        case roundedCross
    }

    case shape(Shape)
    case text(String)
    
    public var view:AnyView{
        switch self {
        case .shape(.square):
            return AnyView(Rectangle())
        case .shape(.triangle):
            return AnyView(Triangle())
        case .shape(.slimRectangle):
            return AnyView(SlimRectangle())
        case .shape(.roundedCross):
            return AnyView(RoundedCross())
        case let .text(text):
            return AnyView(Text(text))
        default:
            return AnyView(Circle())
        }
    }
    
    public static var allCases: [ConfettiType] {
        return [.shape(.circle), .shape(.triangle), .shape(.square), .shape(.slimRectangle), .shape(.roundedCross)]
    }
}

@available(iOS 14.0, macOS 11.0, watchOS 7, tvOS 14.0, *)
public struct ConfettiCannon: View {
    @Binding var counter:Int
    @StateObject private var confettiConfig:ConfettiConfig

    @State var animate:[Bool] = []
    @State var finishedAnimationCouter = 0
    @State var firtAppear = false
    @State var error = ""
    
    /// renders configurable confetti animaiton
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
    public init(counter:Binding<Int>,
         num:Int = 20,
         confettis:[ConfettiType] = ConfettiType.allCases,
         colors:[Color] = [.blue, .red, .green, .yellow, .pink, .purple, .orange],
         confettiSize:CGFloat = 10.0,
         rainHeight: CGFloat = 600.0,
         fadesOut:Bool = true,
         opacity:Double = 1.0,
         openingAngle:Angle = .degrees(60),
         closingAngle:Angle = .degrees(120),
         radius:CGFloat = 300,
         repetitions:Int = 0,
         repetitionInterval:Double = 1.0
    ) {
        self._counter = counter
        var shapes = [AnyView]()
        
        for confetti in confettis{
            for color in colors{
                switch confetti {
                case .shape(_):
                    shapes.append(AnyView(confetti.view.foregroundColor(color).frame(width: confettiSize, height: confettiSize, alignment: .center)))
                default:
                    shapes.append(AnyView(confetti.view.foregroundColor(color).font(.system(size: confettiSize))))
                }
            }
        }
    
        _confettiConfig = StateObject(wrappedValue: ConfettiConfig(
            num: num,
            shapes: shapes,
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
        ))
    }

    public var body: some View {
        ZStack{
            ForEach(finishedAnimationCouter..<animate.count, id:\.self){ i in
                ConfettiContainer(
                    finishedAnimationCouter: $finishedAnimationCouter,
                    confettiConfig: confettiConfig
                )
            }
        }
        .onAppear(){
            firtAppear = true
        }
        .onChange(of: counter){value in
            if firtAppear{
                for i in 0...confettiConfig.repetitions{
                    DispatchQueue.main.asyncAfter(deadline: .now() + confettiConfig.repetitionInterval * Double(i)) {
                        animate.append(false)
                        if(value < animate.count){
                            animate[value-1].toggle()
                        }
                    }
                }
            }
        }
    }
}

@available(iOS 14.0, macOS 11.0, watchOS 7, tvOS 14.0, *)
struct ConfettiContainer: View {
    @Binding var finishedAnimationCouter:Int
    @StateObject var confettiConfig:ConfettiConfig
    @State var firstAppear = true

    var body: some View{
        ZStack{
            ForEach(0...confettiConfig.num-1, id:\.self){_ in
                ConfettiView(confettiConfig: confettiConfig)
            }
        }
        .onAppear(){
            if firstAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + confettiConfig.animationDuration) {
                    self.finishedAnimationCouter += 1
                }
                firstAppear = false
            }
        }
    }
}

@available(iOS 14.0, macOS 11.0, watchOS 7, tvOS 14.0, *)
struct ConfettiView: View{
    @State var location:CGPoint = CGPoint(x: 0, y: 0)
    @State var opacity:Double = 0.0
    @StateObject var confettiConfig:ConfettiConfig
    
    func getShape() -> AnyView {
        return confettiConfig.shapes.randomElement()!
    }
    
    func getColor() -> Color {
        return confettiConfig.colors.randomElement()!
    }
    
    func getSpinDirection() -> CGFloat {
        let spinDirections:[CGFloat] = [-1.0, 1.0]
        return spinDirections.randomElement()!
    }
    
    func getRandomExplosionTimeVariation() -> CGFloat {
         CGFloat((0...999).randomElement()!) / 2100
    }
    
    func getAnimationDuration() -> CGFloat {
        return 0.2 + confettiConfig.explosionAnimationDuration + getRandomExplosionTimeVariation()
    }
    
    func getAnimation() -> Animation {
        return Animation.timingCurve(0, 1, 0, 1, duration: getAnimationDuration())
    }
    
    func getDistance() -> CGFloat {
        return pow(CGFloat.random(in: 0.01...1), 2.0/7.0) * confettiConfig.radius
    }
    
    func getDelayBeforeRainAnimation() -> TimeInterval {
        confettiConfig.explosionAnimationDuration *  0.1
    }

    var body: some View{
        ConfettiAnimationView(shape:getShape(), color:getColor(), spinDirX: getSpinDirection(), spinDirZ: getSpinDirection())
            .offset(x: location.x, y: location.y)
            .opacity(opacity)
            .onAppear(){
                withAnimation(getAnimation()) {
                    opacity = confettiConfig.opacity
                    
                    let randomAngle:CGFloat
                    if confettiConfig.openingAngle.degrees <= confettiConfig.closingAngle.degrees{
                        randomAngle = CGFloat.random(in: CGFloat(confettiConfig.openingAngle.degrees)...CGFloat(confettiConfig.closingAngle.degrees))
                    }else{
                        randomAngle = CGFloat.random(in: CGFloat(confettiConfig.openingAngle.degrees)...CGFloat(confettiConfig.closingAngle.degrees + 360)).truncatingRemainder(dividingBy: 360)
                    }
                    
                    let distance = getDistance()
                    
                    location.x = distance * cos(deg2rad(randomAngle))
                    location.y = -distance * sin(deg2rad(randomAngle))
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + getDelayBeforeRainAnimation()) {
                    withAnimation(Animation.timingCurve(0.12, 0, 0.39, 0, duration: confettiConfig.rainAnimationDuration)) {
                        location.y += confettiConfig.rainHeight
                        opacity = confettiConfig.fadesOut ? 0 : confettiConfig.opacity
                    }
                }
            }
    }
    
    func deg2rad(_ number: CGFloat) -> CGFloat {
        return number * CGFloat.pi / 180
    }
    
}

struct ConfettiAnimationView: View {
    @State var shape: AnyView
    @State var color: Color
    @State var spinDirX: CGFloat
    @State var spinDirZ: CGFloat
    @State var firstAppear = true

    
    @State var move = false
    @State var xSpeed:Double = Double.random(in: 0.501...2.201)

    @State var zSpeed = Double.random(in: 0.501...2.201)
    @State var anchor = CGFloat.random(in: 0...1).rounded()
    
    var body: some View {
        shape
            .foregroundColor(color)
            .rotation3DEffect(.degrees(move ? 360:0), axis: (x: spinDirX, y: 0, z: 0))
            .animation(Animation.linear(duration: xSpeed).repeatCount(10, autoreverses: false), value: move)
            .rotation3DEffect(.degrees(move ? 360:0), axis: (x: 0, y: 0, z: spinDirZ), anchor: UnitPoint(x: anchor, y: anchor))
            .animation(Animation.linear(duration: zSpeed).repeatForever(autoreverses: false), value: move)
            .onAppear() {
                if firstAppear {
                    move = true
                    firstAppear = true
                }
            }
    }
}

class ConfettiConfig: ObservableObject {
    internal init(num: Int, shapes: [AnyView], colors: [Color], confettiSize: CGFloat, rainHeight: CGFloat, fadesOut: Bool, opacity: Double, openingAngle:Angle, closingAngle:Angle, radius:CGFloat, repetitions:Int, repetitionInterval:Double) {
        self.num = num
        self.shapes = shapes
        self.colors = colors
        self.confettiSize = confettiSize
        self.rainHeight = rainHeight
        self.fadesOut = fadesOut
        self.opacity = opacity
        self.openingAngle = openingAngle
        self.closingAngle = closingAngle
        self.radius = radius
        self.repetitions = repetitions
        self.repetitionInterval = repetitionInterval
        self.explosionAnimationDuration = Double(radius / 1400)
        self.rainAnimationDuration = Double((rainHeight + radius) / 200)
    }
    
    @Published var num:Int
    @Published var shapes:[AnyView]
    @Published var colors:[Color]
    @Published var confettiSize:CGFloat
    @Published var rainHeight:CGFloat
    @Published var fadesOut:Bool
    @Published var opacity:Double
    @Published var openingAngle:Angle
    @Published var closingAngle:Angle
    @Published var radius:CGFloat
    @Published var repetitions:Int
    @Published var repetitionInterval:Double
    @Published var explosionAnimationDuration:Double
    @Published var rainAnimationDuration:Double

    
    var animationDuration:Double{
        return explosionAnimationDuration + rainAnimationDuration
    }
    
    var openingAngleRad:CGFloat{
        return CGFloat(openingAngle.degrees) * 180 / .pi
    }
    
    var closingAngleRad:CGFloat{
        return CGFloat(closingAngle.degrees) * 180 / .pi
    }
}
