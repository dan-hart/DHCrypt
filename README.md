# DHCryptography

Swift wrapper for AES encryption, with help from CryptoSwift

### Encrypt
```Swift
try DHCryptography.shared.encrypt(stringDictionary: ["TOKEN": "1234"])
```

### Decrypt
```Swift
let value = try DHCryptography.shared.decryptValue(fromKey: "TOKEN")
print(value) // "1234"
```

[!["Buy Me A Coffee"](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://www.buymeacoffee.com/codedbydan)
