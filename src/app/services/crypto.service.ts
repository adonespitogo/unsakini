// References:
// http://stackoverflow.com/questions/29807108/derive-key-and-iv-from-string-for-aes-encryption-in-cryptojs-and-php
// http://stackoverflow.com/questions/23188593/cryptojs-check-if-aes-passphrase-is-correct
// http://stackoverflow.com/questions/27179685/how-to-encrypt-a-message-at-client-side-using-crypto-js-library-and-decrypt-it-a


import {Injectable} from '@angular/core';
import {BehaviorSubject} from 'rxjs/BehaviorSubject';
declare var CryptoJS: any;

export interface ICryptoObservable {
  status: boolean;
  message: string;
}

@Injectable()

export class CryptoService {

  static iterations = 500
  static keySize = 256;
  static ivSize = 128;

  static valid: boolean;
  static validkey$: BehaviorSubject<ICryptoObservable> =
    new BehaviorSubject<ICryptoObservable>({status: true, message: ''});

  public static keyName: string;

  static setKeyName ({id}) {
    let d = new Date();
    let keyNameWords: string = CryptoJS.enc.Utf8.parse(`${id}_${d.getDate()}`);
    let hash = CryptoJS.SHA256(keyNameWords);
    CryptoService.keyName = hash;
    if (!CryptoService.valid) {
      CryptoService.validkey$.next({status: true, message: 'Key set'});
    }
    CryptoService.valid = true;
  }

  static setKey (k): void {
    let d = new Date();
    let padding = d.getDate();
    let key = CryptoJS.enc.Base64.stringify(CryptoJS.enc.Utf8.parse(`${padding}_${k}`));
    localStorage.setItem(CryptoService.keyName, key);
    if (!CryptoService.valid) {
      CryptoService.validkey$.next({status: true, message: 'Key set'});
    }
    CryptoService.valid = true;
  }

  static getKey(): string {
    let key = localStorage.getItem(CryptoService.keyName);
    if (key == null) {
      return '';
    } else {
      let d = new Date();
      let padding = d.getDate();
      return CryptoJS.enc.Utf8.stringify(CryptoJS.enc.Base64.parse(key)).replace(`${padding}_`, '');
    }
  }

  static removeKey () {
    localStorage.removeItem(CryptoService.keyName);
  }

  static encrypt (msg: string) {
    let encrypted: any;
    let passphrase = CryptoService.getKey();
    let salt = CryptoJS.lib.WordArray.random(128/8);
    let output = CryptoJS.PBKDF2(passphrase, salt, {
        keySize: (CryptoService.keySize+CryptoService.ivSize)/32,
        iterations: CryptoService.iterations
    });
// the underlying words arrays might have more content than was asked: remove insignificant words
    output.clamp();
// split key and IV
    let key = CryptoJS.lib.WordArray.create(output.words.slice(0, CryptoService.keySize/32));
    let iv = CryptoJS.lib.WordArray.create(output.words.slice(CryptoService.keySize/32));
    try {
      encrypted = CryptoJS.AES.encrypt(msg, key, {
        iv: iv,
        mode: CryptoJS.mode.CBC,
        padding: CryptoJS.pad.Pkcs7
      });
    } catch (e) {
      if (CryptoService.valid) {
        CryptoService.validkey$.next({status: false, message: e.toString()});
      }
      CryptoService.valid = false;
      return '';
    }
    encrypted = encrypted ? encrypted.toString() : '';
    let hmac = CryptoJS.HmacSHA256((salt.toString() + encrypted), CryptoJS.SHA256(passphrase)).toString();
    return  hmac + salt.toString() + encrypted;
  }

// base on http://stackoverflow.com/questions/23188593/cryptojs-check-if-aes-passphrase-is-correct
  static decrypt (transitmessage: string) {
    if (!transitmessage || !CryptoService.valid) {
      return '';
    }
    if (!CryptoService.isPassphraseValid(transitmessage)) {
      CryptoService.validkey$.next({
        status: false,
        message: 'Private key is invalid'
      });
      CryptoService.valid = false;
      return false;
    }
    let passphrase = CryptoService.getKey();
    let saltHex = transitmessage.substr(64, 32);
    let salt = CryptoJS.enc.Hex.parse(saltHex);
    let ciphertext = transitmessage.substring(64 + 32);
    let output = CryptoJS.PBKDF2(passphrase, salt, {
        keySize: (CryptoService.keySize+CryptoService.ivSize)/32,
        iterations: CryptoService.iterations
    });
// the underlying words arrays might have more content than was asked: remove insignificant words
    output.clamp();
// split key and IV
    let key = CryptoJS.lib.WordArray.create(output.words.slice(0, CryptoService.keySize/32));
    let iv = CryptoJS.lib.WordArray.create(output.words.slice(CryptoService.keySize/32));
    let decrypted: any;
    try {
      decrypted = CryptoJS.AES.decrypt(ciphertext, key, {
        iv: iv,
        mode: CryptoJS.mode.CBC,
        padding: CryptoJS.pad.Pkcs7
      })
      .toString(CryptoJS.enc.Utf8);
    } catch (e) {
      if (CryptoService.valid) {
        CryptoService.validkey$.next({status: false, message: e.toString()});
      }
      CryptoService.valid = false;
      return '';
    }
    try {
      decrypted = decrypted.toString(CryptoJS.enc.Utf8);
    } catch (e) {
      if (CryptoService.valid) {
        CryptoService.validkey$.next({status: false, message: e.toString()});
      }
      CryptoService.valid = false;
      return '';
    }
    return decrypted;

  }

  private static isPassphraseValid (transitmessage: string) {
    let passphrase = CryptoService.getKey();
    let transithmac = transitmessage.substring(0, 64);
    let transitencrypted = transitmessage.substring(64);
    let decryptedhmac = CryptoJS.HmacSHA256(transitencrypted, CryptoJS.SHA256(passphrase)).toString();
    return (transithmac === decryptedhmac);
  }

}
