//
//  CryptHexStoreTests.swift
//  
//
//  Created by Dan Hart on 3/15/22.
//

@testable import DHCrypt
import XCTest

class CryptHexStoreTests: XCTestCase {
    func testJSONEncode() {
        let store = CryptHexStore(cryptKey: "664f4f7035594831684258374d573464", iv: "83405657222e57f859571d73d6852d5c", cryptValue: "d040cb551aa6d4e585e6103073036b0a00c3846932402c135602250724fad8ae")
        let string = try? store.jsonString()
        let expected = """
{"iv":"83405657222e57f859571d73d6852d5c","cryptKey":"664f4f7035594831684258374d573464","cryptValue":"d040cb551aa6d4e585e6103073036b0a00c3846932402c135602250724fad8ae"}
"""
        XCTAssertEqual(string!, expected)
    }
    
    func testJSONDecode() {
        let json = """
{"iv":"83405657222e57f859571d73d6852d5c","cryptKey":"664f4f7035594831684258374d573464","cryptValue":"d040cb551aa6d4e585e6103073036b0a00c3846932402c135602250724fad8ae"}
"""
        let store = try? CryptHexStore(json)
        let expected = CryptHexStore(cryptKey: "664f4f7035594831684258374d573464", iv: "83405657222e57f859571d73d6852d5c", cryptValue: "d040cb551aa6d4e585e6103073036b0a00c3846932402c135602250724fad8ae")
        
        XCTAssertEqual(store, expected)
    }
    
    func testInit() {
        let store = CryptHexStore.with(cryptKey: "", iv: "", cryptValue: "")
        XCTAssertNotNil(store)
    }
}
