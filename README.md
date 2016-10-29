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

### Directory Structure
 - `./api` - API sources (controllers, models, and other express middlewares)
 - `./src` - Angular 2 app sources
 - `./migrations` - Contains DB migration files (sequelize-cli)
 - `./config` - Contians sequelize-cli config for migrations. Don't confuse it with `./api/config` which contains config files specific to the express app
 
### Technologies
 - Server
  - [Express](http://expressjs.com/) node.js framework for building the API
  - [Sequelize](http://docs.sequelizejs.com/en/v3/) as ORM
  - [Sequelize CLI](http://docs.sequelizejs.com/en/v3/docs/migrations/) for database migrations
 - Frontend
  - [Angular 2](https://angular.io/) framework for the front-end
  - [Angular CLI](https://cli.angular.io/) in developing the Angular app

### Encryption and decryption process
If you look at the network traffic in the browser network tab, you'll see that sensitive data sent to the server are gibberesh. This is because they are encrypted using your private key before being sent. Likewise, the data is being decrypted in the client side using the same key you supplied. The key is stored in your browser's localStorage and is never sent to the server. Therefore, only you can be able to read your data.

The encryption and decryption process happens inside [./src/app/services/crypto.service.ts](./src/app/services/crypto.service.ts).

An exerpt of `crypto.service.ts`'s encryption and decryption methods:
```typescript

import * as CryptoJS from 'crypto-js';
import {BehaviorSubject} from 'rxjs/BehaviorSubject';

export class CryptoService {
  
  // ENCRYPTION METHOD
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
    } catch (e) {
      CryptoService.validkey$.next({status: false, message: e.toString()});
      return err;
    }
    encrypted = encrypted ? encrypted.toString() : '';
    let hmac = CryptoJS.HmacSHA256(encrypted, CryptoJS.SHA256(passphrase)).toString();
    return hmac + encrypted;
  }
  
  //DECRYPTION METHOD
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

**To security experts: Please let me know if you know of a more secure way of encrypting data. This is by far the most effective method base on my research.**

### Author
[Adones Pitogo](http://adonespitogo.com)

### License
Released under the terms of [MIT](https://opensource.org/licenses/MIT) License.
