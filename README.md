###UNSAKINI


**Unsakini** ("what is this") in Cebuano language is a web app that encrypts data in the client-side and sends encrypted data to the server. This way, only you can access your data so it stays safe from everyone else, even when the server gets compromised.

The source code is opensourced so you can review it and deploy it on your own server. Anyhow, you can always make use of the deployed app at [www.unsakini.com](https://www.unsakini.com).

### Planned Features
- [x] Encrypt data
- [ ] Upload and encrypt files
- [ ] Share encrypted data and files to other users

-------------------------
### Getting Started
```
$ npm install -g gulp sequelize sequelize-cli typescript typings coffee-script angular-cli
$ npm install
```

**Note:** Make sure to create a dev database setup (mysql) with db name `unsakini`, `username=root` and `password=null` in your localhost.

### Development

Run server
```
$ node index.js
```
Build the Angular2 app
```
$ ng build
```
Browse to [http://localhost:3000](http://localhost:3000)


Angular app sources are under the `./src/app` directory, while the api sources are under the `./api` directory.

### Encryption and decryption process
If you look at the network traffic in the browser network tab, you'll see that sensitive data sent to the server are gibberesh. This is because they are encrypted using your private key before being sent. Likewise, the data is being decrypted in the client side using the same key you supplied. The key is stored in your browser's localStorage and is never sent to the server. Therefore, only you can be able to read your data.

The encryption and decryption process happens inside `src/app/services/crypto.service.ts`.
```

import * as CryptoJS from 'crypto-js';

export class CryptoService {

  static getKey(): string {
    let key = localStorage.getItem('crypto_key');
    if (key) {
      return key.toString();
    } else {
      return '';
    }
  }

  static setKey (k): void {
    // $.jStorage.set('crypto_key', k);
    localStorage.setItem('crypto_key', k);
  }

  static decrypt (msg: string) {
    let key = CryptoService.getKey();
    let bytes: any;
    try {
      bytes = CryptoJS.AES.decrypt(msg, key);
    } catch (e) {
    }
    if (bytes) {
      return bytes.toString(CryptoJS.enc.Utf8);
    } else {
      return 'UNPARSABLE';
    }
  }

  static encrypt (msg: string) {
    let key = CryptoService.getKey();
    // if (!msg || !key) {
    //   return '';
    // }
    let ciphertext: any;
    try {
     ciphertext = CryptoJS.AES.encrypt(msg, key);
    } catch (e) {
      console.log(e);
    }
    if (ciphertext) {
      return ciphertext.toString();
    } else {
      return msg;
    }
  }
}

```
