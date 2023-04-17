import XCTest
@testable import lid

final class lidTests: XCTestCase {
    func testManifestDecoding() throws {
        // Given
        let testManifest = try XCTUnwrap(
            Bundle.module.url(forResource: "test-manifest", withExtension: "yml")
        )

        // When
        let tools = try lid().decodeManifestFile(at: testManifest)

        // Then
        XCTAssertNotNil(tools)
    }
}
