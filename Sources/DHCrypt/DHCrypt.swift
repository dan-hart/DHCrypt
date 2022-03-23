import Foundation
import FileKit

open class DHCrypt: DHCrypting {
    public static let subfolderName = "Sourceless"
    public var shard: DHCrypting = DHCrypt()
    
    // MARK: - Functions
    func writeEncrypted(value: Data?, to: Path) throws -> Path? {
        guard let value = value else {
            throw DHCryptError.nilData
        }

        let encryptedStore = value.encrypt()
        return nil
    }
}
