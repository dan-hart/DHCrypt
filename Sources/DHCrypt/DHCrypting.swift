//
//  DHCrypting.swift
//  
//
//  Created by Dan Hart on 3/23/22.
//

import Foundation
import FileKit

public protocol DHCrypting {
    static var shared: DHCrypting { get set }
    
    func encrypt(stringDictionary: [String: String]) throws -> Path?
    func encrypt(_ data: Data?) throws -> Path?
    func decryptValue(fromKey: String) throws -> String?
    func delete(key: String) throws -> Path?
    func convert(fromData: Data) throws -> [String: String]?
}
