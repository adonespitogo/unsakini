import {Injectable} from '@angular/core';
import * as CryptoJS from 'crypto-js';
import {BehaviorSubject} from 'rxjs/BehaviorSubject';

export interface ICryptoObservable {
  status: boolean;
  message: string;
}

@Injectable()

export class CryptoService {

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
    } catch (e) {
      if (CryptoService.valid) {
        CryptoService.validkey$.next({status: false, message: e.toString()});
      }
      CryptoService.valid = false;
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
    if (!passphrase && CryptoService.valid) {
      CryptoService.validkey$.next({
        status: false,
        message: 'Unable to locate your private key.'
      });
      CryptoService.valid = false;
      return '[private key is not set]';
    }
    let transithmac = transitmessage.substring(0, 64);
    let transitencrypted = transitmessage.substring(64);
    let decryptedhmac = CryptoJS.HmacSHA256(transitencrypted, CryptoJS.SHA256(passphrase)).toString();
    let correctpassphrase: boolean = (transithmac === decryptedhmac);
    if (!correctpassphrase) {
      if (CryptoService.valid) {
        CryptoService.validkey$.next({
          status: false,
          message: `Private key does not match the original key footprint.`
        });
      }
      CryptoService.valid = false;
      return '[incorrect key]';
    }
    let decrypted: any;
    try {
      decrypted = CryptoJS.AES.decrypt(transitencrypted, passphrase).toString(CryptoJS.enc.Utf8);
    } catch (e) {
      if (CryptoService.valid) {
        CryptoService.validkey$.next({status: false, message: e.toString()});
      }
      CryptoService.valid = false;
      return err;
    }
    try {
      decrypted = decrypted.toString(CryptoJS.enc.Utf8);
    } catch (e) {
      if (CryptoService.valid) {
        CryptoService.validkey$.next({status: false, message: e.toString()});
      }
      CryptoService.valid = false;
      return err;
    }
    return decrypted;

  }

}
