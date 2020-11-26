import XCTest
@testable import ConfettiSwiftUI

import SwiftUI

final class ConfettiSwiftUITests: XCTestCase {
    @State var counter = 0
    
    func testExample() {
        ConfettiSwiftUI.ConfettiCannon(counter:$counter)
        Button("Animation"){
            self.counter += 1
        }
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
