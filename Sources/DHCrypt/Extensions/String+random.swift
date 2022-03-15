//
//  String+random.swift
//  DHCrypt
//
//  Created by Dan Hart on 3/15/22.
//

import Foundation

public extension String {
    static func random(ofLength length: Int) -> String {
        return random(minimumLength: length, maximumLength: length)
    }
    
    static func random(minimumLength min: Int, maximumLength max: Int) -> String {
        return random(
            withCharactersInString: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789",
            minimumLength: min,
            maximumLength: max
        )
    }

    static func random(withCharactersInString string: String, minimumLength min: Int, maximumLength max: Int) -> String {
        guard min > 0 && max >= min else {
            return ""
        }
        
        let length: Int = (min < max) ? .random(in: min...max) : max
        var randomString = ""
        
        (1...length).forEach { _ in
            let randomIndex: Int = .random(in: 0..<string.count)
            let c = string.index(string.startIndex, offsetBy: randomIndex)
            randomString += String(string[c])
        }
        
        return randomString
    }
}
