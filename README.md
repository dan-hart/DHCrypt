# DHCrypt

Swift wrapper for AES encryption, with help from CryptoSwift

### Encrypt
```
let sensitiveDictionary = ["API_KEY": "1234"]
let key = String.random(ofLength: 16)
let store = sensitiveDictionary.data?.encrypt(using: key)
// write store to disk, send via json, etc.
```

### Decrypt
```
// get hex values from disk as strings, pass to CryptHexStore and call .decrypted
let decryptedData = CryptHexStore(cryptKey: "664f4f7035594831684258374d573464", iv: "83405657222e57f859571d73d6852d5c", cryptValue: "d040cb551aa6d4e585e6103073036b0a00c3846932402c135602250724fad8ae").decrypted
print(String(data: decryptedData!, encoding: .utf8)!) // {"API_KEY":"1234"}
```
