import Foundation

open class DHCryptography: DHCryptographing {
    public static var shared: DHCryptographing = DHCryptography()
    
    // MARK: - Methods
    @discardableResult
    public func encrypt(stringDictionary: [String: String]) -> DHCryptographyHexStore? {
        return encrypt(stringDictionary.data)
    }
    
    @discardableResult
    public func encrypt(_ data: Data?) -> DHCryptographyHexStore? {
        guard let data = data else {
            return nil
        }

        return data.encrypt()
    }
    
    // MARK: - Helper
    public func convert(fromData: Data) throws -> [String: String]? {
        return try JSONSerialization.jsonObject(with: fromData, options: []) as? [String: String]
    }
}
