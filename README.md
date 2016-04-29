```js
  key = 'My Secret Passphrase'
  message = 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Non, eligendi similique delectus quaerat officiis reprehenderit, consectetur aliquid velit, sequi nisi hic magni voluptas. Deleniti maxime similique harum possimus veniam nesciunt.'
  encryptedAES = CryptoJS.AES.encrypt(message, key)
  encryptedAESString = encryptedAES.toString()
  decrypted = CryptoJS.AES.decrypt(encryptedAESString, key)
  console.log decrypted.toString(CryptoJS.enc.Utf8)
```