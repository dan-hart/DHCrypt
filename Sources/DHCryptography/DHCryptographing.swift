//
//  DHCryptographing.swift
//  
//
//  Created by Dan Hart on 3/23/22.
//

import Foundation

public protocol DHCryptographing {
    static var shared: DHCryptographing { get set }
    
    @discardableResult
    func encrypt(stringDictionary: [String: String]) -> DHCryptographyHexStore?
    @discardableResult
    func encrypt(_ data: Data?) -> DHCryptographyHexStore?
    func convert(fromData: Data) throws -> [String: String]?
}
