UNSAKINI
-----------

**Unsakini** ("what is this") in Cebuano language is a web app that encrypts data in the client-side and sends encrypted data to the server. This way, only you can access your data so it stays safe from everyone else, even when the server gets compromised.

The source code is opensourced so you can review it and deploy it on your own server. Anyhow, you can always make use of the deployed app at [www.unsakini.com](https://www.unsakini.com).

### Planned Features
- [x] Encrypt data
- [ ] Upload and encrypt files
- [ ] Share encrypted data and files to other users

-------------------------
### Getting Started
```
$ npm install -g gulp sequelize sequelize-cli typescript typings coffee-script angular-cli mysql
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

The encryption and decryption process happens inside [./src/app/services/crypto.service.ts](./src/app/services/crypto.service.ts).
```typescript

import * as CryptoJS from 'crypto-js';
import {BehaviorSubject} from 'rxjs/BehaviorSubject';

export interface ICryptoObservable {
  status: boolean;
  message: string;
}

export class CryptoService {

  static validkey$: BehaviorSubject<ICryptoObservable> =
    new BehaviorSubject<ICryptoObservable>({status: true, message: ''});

  private static keyName: string;

  static setKeyName (user) {
    CryptoService.keyName = window.btoa(`user_${user.id}_crypto_key`);
  }

  static setKey (k): void {
    localStorage.setItem(CryptoService.keyName, window.btoa(k));
  }

  static getKey(): string {
    let key = localStorage.getItem(CryptoService.keyName);
    if (key == null) {
      return '';
    } else {
      return window.atob(key);
    }
  }

  static removeKey () {
    localStorage.removeItem(CryptoService.keyName);
  }

  // base on http://stackoverflow.com/questions/23188593/cryptojs-check-if-aes-passphrase-is-correct
  static encrypt (msg: string) {
    if (!msg) {
      return '';
    }
    let err = '[encryption error]';
    let key = CryptoService.getKey();
    let passphrase = key;
    let encrypted: any;
    try {
      encrypted = CryptoJS.AES.encrypt(msg, key);
      CryptoService.validkey$.next({status: true, message: ''});
    } catch (e) {
      CryptoService.validkey$.next({status: false, message: e.toString()});
      return err;
    }
    encrypted = encrypted ? encrypted.toString() : '';
    let hmac = CryptoJS.HmacSHA256(encrypted, CryptoJS.SHA256(passphrase)).toString();
    return hmac + encrypted;
  }
  
  // base on http://stackoverflow.com/questions/23188593/cryptojs-check-if-aes-passphrase-is-correct
  static decrypt (msg: string) {
    if (!msg) {
      return '';
    }
    let err = '[decryption error]';
    let transitmessage = msg;
    let passphrase = CryptoService.getKey();
    if (!passphrase) {
      CryptoService.validkey$.next({
        status: false,
        message: 'Unable to locate your private key.'
      });
      return '';
    }
    let transithmac = transitmessage.substring(0, 64);
    let transitencrypted = transitmessage.substring(64);
    let decryptedhmac = CryptoJS.HmacSHA256(transitencrypted, CryptoJS.SHA256(passphrase)).toString();
    let correctpassphrase: boolean = (transithmac === decryptedhmac);
    if (!correctpassphrase) {
      CryptoService.validkey$.next({
        status: false,
        message: `Private key does not match the original key footprint. Your key might be incorrect.`
      });
      return err;
    }
    let decrypted: any;
    try {
      decrypted = CryptoJS.AES.decrypt(transitencrypted, passphrase).toString(CryptoJS.enc.Utf8);
      CryptoService.validkey$.next({status: true, message: ''});
    } catch (e) {
      CryptoService.validkey$.next({status: false, message: e.toString()});
      return err;
    }
    try {
      decrypted = decrypted.toString(CryptoJS.enc.Utf8);
      CryptoService.validkey$.next({status: true, message: ''});
    } catch (e) {
      CryptoService.validkey$.next({status: false, message: e.toString()});
      return err;
    }
    return decrypted;

  }

}


```

### Author
[Adones Pitogo](http://adonespitogo.com)

### License
Released under the terms of [MIT](https://opensource.org/licenses/MIT) License.
