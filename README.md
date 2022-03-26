# DHCryptography

Swift wrapper for AES encryption, with help from CryptoSwift

### Encrypt
```Swift
let store = DHCryptography.shared.encrypt(stringDictionary: ["TOKEN": "1234"])
```

### Decrypt
```Swift
guard let decryptedData = store?.decrypted else { return }
let keyValue = String(data: decryptedData, encoding: .utf8)
print(keyValue) // "{ "TOKEN": "1234" }"
```

[!["Buy Me A Coffee"](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://www.buymeacoffee.com/codedbydan)
