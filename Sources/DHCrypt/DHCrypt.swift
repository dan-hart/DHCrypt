import Foundation
import FileKit

open class DHCrypt: DHCrypting {
    public static var shared: DHCrypting = DHCrypt()
    
    public static let subfolderName = "DHCrypt"
    public static let dataFileExtension = "json"
    
    public var cryptPath: Path {
        guard let documentsPath = FileManager.default.documentsDirectoryPath else {
            return Path.current
        }
        return documentsPath + Path(DHCrypt.subfolderName)
    }
    
    public var jsonFilePathArray: [Path] {
        let jsonFiles = cryptPath.find(searchDepth: 1) { path in
            path.pathExtension == DHCrypt.dataFileExtension
        }
        
        if jsonFiles.isEmpty {
            return []
        } else {
            return jsonFiles
        }
    }
    
    public var codableFiles: [File<CryptHexStore>] {
        var codableFiles = [File<CryptHexStore>]()
        for jsonFilePath in jsonFilePathArray {
            codableFiles.append(File<CryptHexStore>(path: jsonFilePath))
        }
        return codableFiles
    }
    
    public var keyValuePairArray: [[String: String]] {
        var keyValuePairArray: [[String: String]] = []
        for codableFile in codableFiles {
            guard let store = try? codableFile.read() else { continue }
            guard let decrypted = store.decrypted else { continue }
            if let keyValuePair = try? convert(fromData: decrypted) {
                keyValuePairArray.append(keyValuePair)
            }
        }
        return keyValuePairArray
    }
    
    public var keyValuePairs: [String: String]? {
        var keyValuePairsDictionary: [String: String] = [:]
        for keyValuePairs in keyValuePairArray {
            for keyValuePair in keyValuePairs {
                let key = keyValuePair.key
                let value = keyValuePair.value
                if let _ = keyValuePairsDictionary[key] {
                    return nil
                } else {
                    keyValuePairsDictionary[key] = value
                }
            }
        }
        return keyValuePairsDictionary
    }
    
    // MARK: - Methods
    
    public func encrypt(stringDictionary: [String: String]) throws -> Path? {
        return try encrypt(stringDictionary.data)
    }
    
    public func encrypt(_ data: Data?) throws -> Path? {
        guard let data = data else {
            return nil
        }

        let store = data.encrypt()
        return try store?.writeToDisk(at: cryptPath)
    }
    
    /// Add keys, then use this method to retrieve them at runtime.
    /// - Parameter fromKey: the identifier for the value needed
    /// - Returns: the value from disk for the specified key
    public func decryptValue(fromKey: String) throws -> String? {
        guard let keyValuePairs = keyValuePairs else {
            return nil
        }
        
        for keyValuePair in keyValuePairs {
            if keyValuePair.key == fromKey {
                return keyValuePair.value
            }
        }
        
        return nil
    }
    
    public func delete(key: String) throws -> Path? {
        for codableFile in codableFiles {
            guard let store = try? codableFile.read() else { continue }
            guard let decrypted = store.decrypted else { continue }
            if let keyValuePairs = try? convert(fromData: decrypted) {
                for keyValuePair in keyValuePairs where keyValuePair.key == key {
                    try codableFile.delete()
                    return codableFile.path
                }
            }
        }
        return nil
    }
    
    // MARK: - Helper
    public func convert(fromData: Data) throws -> [String: String]? {
        return try JSONSerialization.jsonObject(with: fromData, options: []) as? [String: String]
    }
}
