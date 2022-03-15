//
//  Data+encrypt.swift
//  DHCrypt
//
//  Created by Dan Hart on 3/15/22.
//

import Foundation
import CryptoSwift

public extension Data {
    var asUInt8Array: [UInt8] {
        [UInt8](self)
    }
    
    /// AES-encrypt this data with a 16-character encryption key
    func encrypt(using encryptionKey: String = String.random(ofLength: 16), with encoding: String.Encoding = .utf8) -> CryptHexStore? {
        if encryptionKey.count != 16 { return nil }
        guard let encryptionKeyData = encryptionKey.data(using: encoding) else { return nil }
        let encryptionKeyArray = encryptionKeyData.asUInt8Array
        let ivArray = AES.randomIV(AES.blockSize)
        do {
            let encrypted = try AES(key: encryptionKeyArray, blockMode: CBC(iv: ivArray), padding: .pkcs7).encrypt(self.asUInt8Array)
            return CryptHexStore(cryptKey: encryptionKeyArray.toHexString(), iv: ivArray.toHexString(), cryptValue: encrypted.toHexString())
        } catch {
            return nil
        }
    }
}
