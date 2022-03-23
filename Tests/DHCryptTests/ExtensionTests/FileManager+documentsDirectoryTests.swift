//
//  FileManager_documentsDirectoryTests.swift
//  
//
//  Created by Dan Hart on 3/23/22.
//

@testable import DHCrypt
@testable import FileKit
import XCTest

class FileManager_documentsDirectoryTests: XCTestCase {
    func testDocumentsDirectoryURL() {
        XCTAssertNotNil(FileManager.default.documentsDirectoryURL)
    }
    
    func testDocumentsDirectoryPath() {
        XCTAssertNotNil(FileManager.default.documentsDirectoryPath)
    }
}
