UNSAKINI
-----------

todo: Modify description

**Unsakini** ("what is this") in Cebuano language is a bulletin board that encrypts data in the client-side and sends encrypted data to the server. This way, only you can access your data so it stays safe from everyone else, even when the server gets compromised.

The source code is opensourced so you can review it and deploy it on your own server. Anyhow, you can always make use of the deployed app at [www.unsakini.com](https://www.unsakini.com).

### Planned Features
- [x] Encrypt data
- [ ] Upload and encrypt files
- [ ] Share encrypted data and files to other users

-------------------------
### Installation

Installation instructions here...

### Configuration

configurations instructions here..


### Encryption and Decryption Process
If you look at the network traffic in the browser network tab, you'll see that sensitive data sent to the server are gibberesh. This is because they are encrypted using your private key before being sent. The data is being decrypted in the client side using the same key you supplied. The key is stored in your browser's localStorage and is never sent to the server. Therefore, only you can be able to access your data.

To increase the security, the data is also encrypted in the server before saving to the database, which adds a second layer of security.

The encryption and decryption process happens inside [./src/app/services/crypto.service.ts](./src/app/services/crypto.service.ts) on the client-side and [./api/services/crypto.coffee](./api/services/crypto.coffee) on the server-side.

The data is ecnrypted using [Advanced Encryption System (AES)](https://en.wikipedia.org/wiki/Advanced_Encryption_Standard), the most widely used and trusted encryption algorithm.

**Encryption Specifications** (both server and client)
 - Algorithm = `AES`
 - Mode = `CBC`
 - Padding = `Pkcs7`
 - Key Derivation Function = `PBKDF2`
 - Key Size = `256`
 - Initialization Vector Size = `128`
 - PBKDF2 iterations = `500`

### Author
[Adones Pitogo](http://adonespitogo.com)

### License
Released under the terms of [MIT](https://opensource.org/licenses/MIT) License.
