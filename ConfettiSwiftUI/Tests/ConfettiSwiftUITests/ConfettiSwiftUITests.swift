import XCTest
@testable import ConfettiSwiftUI

import SwiftUI

final class ConfettiSwiftUITests: XCTestCase {
    @State var trigger: String = ""
    
    func testExample() {
        ConfettiSwiftUI.ConfettiCannon(trigger: $trigger)
        Button("Animation"){
            self.trigger += " "
        }
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
