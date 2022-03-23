import Foundation
import FileKit

open class DHCrypt: DHCrypting {
    public static let subfolderName = "Sourceless"
    public static let dataFileExtension = "json"
    
    public var shard: DHCrypting = DHCrypt()
    
    // MARK: - Methods
    
    /// Add keys, then use this method to retrieve them at runtime.
    /// - Parameter fromKey: the identifier for the value needed
    /// - Returns: the value from disk for the specified key
    public func getValue(fromKey: String) throws -> String? {
        guard let documentsPath = FileManager.default.documentsDirectoryPath else {
            throw DHCryptError.invalidDocumentsPath
        }
        
        let searchPath = documentsPath + Path(DHCrypt.subfolderName)
        
        let jsonFiles = searchPath.find(searchDepth: 1) { path in
            path.pathExtension == DHCrypt.dataFileExtension
        }
        
        if jsonFiles.isEmpty {
            throw DHCryptError.emptyDirectoryNoJSONFiles
        }
        
        for jsonFilePath in jsonFiles {
            let codableFile = File<CryptHexStore>(path: jsonFilePath)
            guard let store = try? codableFile.read() else { continue }
            guard let decrypted = store.decrypted else { continue }
            guard let keyValuePairs = try? convert(fromData: decrypted) else { continue }
            for keyValuePair in keyValuePairs {
                if keyValuePair.key == fromKey {
                    return keyValuePair.value
                }
            }
        }
        
        return nil
    }
    
    // MARK: - Helper
    func convert(fromData: Data) throws -> [String: String]? {
        return try JSONSerialization.jsonObject(with: fromData, options: []) as? [String: String]
    }
}
