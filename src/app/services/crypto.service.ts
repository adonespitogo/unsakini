
import * as CryptoJS from 'crypto-js';
import {BehaviorSubject} from 'rxjs/BehaviorSubject';
// import {UserService} from './user.service';
// import {UserModel} from '../models/user.model';

export interface ICryptoObservable {
  status: boolean;
  message: string;
}

export class CryptoService {

  // algo based on http://stackoverflow.com/questions/23188593/cryptojs-check-if-aes-passphrase-is-correct

  // constructor (private userService: UserService) {
  //   console.log(this.userService);
  // }

  static validkey$: BehaviorSubject<ICryptoObservable> =
    new BehaviorSubject<ICryptoObservable>({status: false, message: 'Uninitialized private key name.'});
  private static keyName: string;

  static setKeyName (user) {
    CryptoService.keyName = window.btoa(`user_${user.id}_crypto_key`);
  }

  static getKey(): string {
    let key = localStorage.getItem(CryptoService.keyName);
    if (key) {
      return key.toString();
    } else {
      return '';
    }
  }

  static setKey (k): void {
    localStorage.setItem(CryptoService.keyName, k);
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
      console.log(e);
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
      CryptoService.validkey$.next({status: false, message: 'Unable to locate your private key. Empty CryptoService.keyName'});
      return '';
    }
    let transithmac = transitmessage.substring(0, 64);
    let transitencrypted = transitmessage.substring(64);
    let decryptedhmac = CryptoJS.HmacSHA256(transitencrypted, CryptoJS.SHA256(passphrase)).toString();
    let correctpassphrase: boolean = (transithmac === decryptedhmac);
    if (!correctpassphrase) {
      CryptoService.validkey$.next({status: false, message: `Incorrect passphrase used in decryptiion.`});
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
