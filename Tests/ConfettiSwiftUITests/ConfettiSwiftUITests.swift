import XCTest
@testable import ConfettiSwiftUI

import SwiftUI

final class ConfettiSwiftUITests: XCTestCase {
    @State var trigger = false

    func testExample() {
        ConfettiSwiftUI.ConfettiCannon(trigger: $trigger)
        Button("Animation"){
            self.trigger.toggle()
        }
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
