//
//  CryptHexStore.swift
//  DHCrypt
//
//  Created by Dan Hart on 3/15/22.
//

import Foundation
import CryptoSwift
import FileKit

extension CryptHexStore: JSONReadableWritable {}

public struct CryptHexStore: Codable, Equatable {
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

public extension CryptHexStore {
    func writeToDisk(at path: Path) throws -> Path {
        let unique = UUID().uuidString
        let directoryPath = path + DHCrypt.subfolderName
        try directoryPath.createDirectory()
        let filePath = directoryPath + "\(unique).json"
        let codableFile = File<CryptHexStore>(path: filePath)
        
        if (try? codableFile.read()) != nil {
            throw DHCryptError.fileAlreadyExists
        } else {
            try codableFile.write(self)
        }
        
        if codableFile.exists && codableFile.size ?? 0 > 0 {
            return codableFile.path
        } else {
            throw DHCryptError.fileDoesNotExist
        }
    }
}

// MARK: CryptHexStore convenience initializers and mutators
public extension CryptHexStore {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(CryptHexStore.self, from: data)
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
     ) -> CryptHexStore {
         return CryptHexStore(
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
