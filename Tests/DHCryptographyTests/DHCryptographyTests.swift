import XCTest
@testable import DHCryptography

class DHCryptographyTests: XCTestCase {
    func testHappyPath() {
        let store = DHCryptography.shared.encrypt(stringDictionary: ["TOKEN": "1234"])
        guard let value = store?.decrypted else { return XCTFail("Unable to decrypt") }
        print(value) // "1234"
        XCTAssertEqual(String(data: value, encoding: .utf8), "{\"TOKEN\":\"1234\"}")
    }
}
