import XCTest
@testable import DHCrypt

class DHCryptTests: XCTestCase {
    func testEncryptDictionary() throws {
        let encryptedFilePath = try DHCrypt.shared.encrypt(stringDictionary: ["Hi": "Hello"])
        XCTAssertEqual(encryptedFilePath?.exists, true)
    }
    
    func testEncryptData() throws {
        let data = ["Hi": "Hello"].data
        let encryptedFilePath = try DHCrypt.shared.encrypt(data)
        XCTAssertEqual(encryptedFilePath?.exists, true)
    }
    
    func testDelete() throws {
        let store = CryptHexStore(cryptKey: "664f4f7035594831684258374d573464", iv: "83405657222e57f859571d73d6852d5c", cryptValue: "d040cb551aa6d4e585e6103073036b0a00c3846932402c135602250724fad8ae")
        if let path = FileManager.default.documentsDirectoryPath {
            let writtenFilePath = try store.writeToDisk(at: path)
            XCTAssertTrue(writtenFilePath.url.absoluteString.contains(DHCrypt.subfolderName))
            XCTAssertTrue(writtenFilePath.exists)
            
            let value = try? DHCrypt.shared.decryptValue(fromKey: "API_VALUE")
            XCTAssertEqual(value, "1234")
            
            let deletedPath = try DHCrypt.shared.delete(key: "API_VALUE")
            XCTAssertFalse(deletedPath?.exists ?? true)
        } else {
            XCTFail("Documents Directory Path is nil")
        }
    }
}
