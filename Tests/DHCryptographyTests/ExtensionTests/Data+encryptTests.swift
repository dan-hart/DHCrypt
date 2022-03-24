//
//  Data+encryptTests.swift
//  
//
//  Created by Dan Hart on 3/15/22.
//

@testable import DHCryptography
import XCTest

class Data_encryptTests: XCTestCase {
    func testDataEncryption() {
        let sensitiveDictionary = ["API_KEY": "1234"]
        let key = String.random(ofLength: 16)
        let store = sensitiveDictionary.data?.encrypt(using: key)
        XCTAssertEqual(store?.cryptKey, key.data(using: .utf8)!.asUInt8Array.toHexString())
        XCTAssertNotNil(store?.iv)
        XCTAssertNotNil(store?.cryptValue)
    }
    
    func testDataDecryption() {
        let decryptedData = DHCryptographyHexStore(cryptKey: "664f4f7035594831684258374d573464", iv: "83405657222e57f859571d73d6852d5c", cryptValue: "d040cb551aa6d4e585e6103073036b0a00c3846932402c135602250724fad8ae").decrypted

        XCTAssertEqual(String(data: decryptedData!, encoding: .utf8)!, "{\"API_VALUE\":\"1234\"}")
    }
}
