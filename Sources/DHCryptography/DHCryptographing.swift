//
//  DHCryptographing.swift
//  
//
//  Created by Dan Hart on 3/23/22.
//

import Foundation
import FileKit

public protocol DHCryptographing {
    static var shared: DHCryptographing { get set }
    
    @discardableResult
    func encrypt(stringDictionary: [String: String]) throws -> File<DHCryptographyHexStore>?
    @discardableResult
    func encrypt(_ data: Data?) throws -> File<DHCryptographyHexStore>?
    func decryptValue(fromKey: String) throws -> String?
    @discardableResult
    func delete(key: String) throws -> Path?
    func convert(fromData: Data) throws -> [String: String]?
}
