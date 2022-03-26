//
//  DHCryptographyHexStore.swift
//  DHCryptography
//
//  Created by Dan Hart on 3/15/22.
//

import Foundation
import CryptoSwift

public struct DHCryptographyHexStore: Codable, Equatable {
    public var decrypted: Data? {
        let key = Array<UInt8>(hex: cryptKey)
        let iv = Array<UInt8>(hex: iv)
        let value = Array<UInt8>(hex: cryptValue)
        guard let decrypted = try? AES(key: key, blockMode: CBC(iv: iv), padding: .pkcs7).decrypt(value) else { return nil }
        return Data(decrypted)
    }
    
    public let cryptKey: String
    public let iv: String
    
    public let cryptValue: String
}

// MARK: DHCryptographyHexStore convenience initializers and mutators
public extension DHCryptographyHexStore {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DHCryptographyHexStore.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
    
    static func with(
         cryptKey: String,
         iv: String,
         cryptValue: String
     ) -> DHCryptographyHexStore {
         return DHCryptographyHexStore(
             cryptKey: cryptKey,
             iv: iv,
             cryptValue: cryptValue
         )
     }
}

// MARK: - Helper functions for creating encoders and decoders
func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}
