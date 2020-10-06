import XCTest
@testable import ImageResizerCLI

final class ImageResizerCLITests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(ImageResizerCLI().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
