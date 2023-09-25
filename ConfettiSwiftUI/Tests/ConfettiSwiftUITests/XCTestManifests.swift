import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(ConfettiSwiftUITests.allTests),
    ]
}
#endif
