
import * as CryptoJS from 'crypto-js';
import {BehaviorSubject} from 'rxjs/BehaviorSubject';

export class CryptoService {

  // algo based on http://stackoverflow.com/questions/23188593/cryptojs-check-if-aes-passphrase-is-correct

  static validkey$: BehaviorSubject<boolean> = new BehaviorSubject<boolean>(true);

  static getKey(): string {
    let key = localStorage.getItem('crypto_key');
    if (key) {
      return key.toString();
    } else {
      return '';
    }
  }

  static setKey (k): void {
    localStorage.setItem('crypto_key', k);
  }

  static removeKey () {
    localStorage.removeItem('crypto_key');
  }

  static encrypt (msg: string) {
    let err = '[encryption error]';
    let key = CryptoService.getKey();
    let passphrase = key;
    let encrypted: any;
    try {
      encrypted = CryptoJS.AES.encrypt(msg, key);
      CryptoService.validkey$.next(true);
    } catch (e) {
      console.log(e);
      CryptoService.validkey$.next(false);
      return err;
    }
    encrypted = encrypted ? encrypted.toString() : '';
    let hmac = CryptoJS.HmacSHA256(encrypted, CryptoJS.SHA256(passphrase)).toString();
    return hmac + encrypted;
  }

  static decrypt (msg: string) {
    let err = '[decryption error]';
    let transitmessage = msg;
    let passphrase = CryptoService.getKey();
    let transithmac = transitmessage.substring(0, 64);
    let transitencrypted = transitmessage.substring(64);
    let decryptedhmac = CryptoJS.HmacSHA256(transitencrypted, CryptoJS.SHA256(passphrase)).toString();
    let correctpassphrase: boolean = (transithmac === decryptedhmac);
    if (!correctpassphrase) {
      CryptoService.validkey$.next(false);
      return err;
    }
    let decrypted: any;
    try {
      decrypted = CryptoJS.AES.decrypt(transitencrypted, passphrase).toString(CryptoJS.enc.Utf8);
      CryptoService.validkey$.next(true);
    } catch (e) {
      CryptoService.validkey$.next(false);
      return err;
    }
    try {
      decrypted = decrypted.toString(CryptoJS.enc.Utf8);
      CryptoService.validkey$.next(true);
    } catch (e) {
      CryptoService.validkey$.next(false);
      return err;
    }
    return decrypted;

  }

}
