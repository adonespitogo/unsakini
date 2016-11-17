UNSAKINI
-----------

**[Unsakini](https://www.unsakini.com)** is an open source encrypted bulletin board that let's you collaborate, store and share information securely made on top of [Rails 5](http://rubyonrails.org/) and [Angular 2](https://angular.io/).

### Planned Features
- [x] Encrypt data
- [ ] Upload and encrypt files
- [ ] Share encrypted data and files to other users

-------------------------
### Installation

Installation instructions here...

### Configuration

configurations instructions here..

### Documentation
 - The backend is a traditional [Rails 5](http://rubyonrails.org/) app. See the [YARD documentation](https://www.unsakini.com/docs/backend/).
 - The frontend is made of [Angular 2](https://angular.io/). See the [documentation](https://www.unsakini.com/docs/frontend/).

### Encryption and Decryption Process
If you look at the network traffic in the browser network tab, you'll see that sensitive data sent to the server are gibberesh. This is because they are encrypted using your private key before being sent. The data is being decrypted in the client side using the same key you supplied. The key is stored in your browser's localStorage and is never sent to the server. Therefore, only you can be able to access your data.

To increase the security, the data is also encrypted in the server before saving to the database, which adds a second layer of security.

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
