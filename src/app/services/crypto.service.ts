
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
        message: `Private key does not match the original key footprint. Your key might be encorrect.`
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
