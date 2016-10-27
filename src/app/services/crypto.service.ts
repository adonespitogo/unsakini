
import * as CryptoJS from 'crypto-js';
import {BehaviorSubject} from 'rxjs/BehaviorSubject';

export class CryptoService {

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

  static decrypt (msg: string) {
    let key = CryptoService.getKey();
    let bytes: any;
    let str: string;
    try {
      bytes = CryptoJS.AES.decrypt(msg, key);
      CryptoService.validkey$.next(true);
    } catch (e) {
      console.log(e);
      CryptoService.validkey$.next(false);
    }
    try {
      str = bytes.toString(CryptoJS.enc.Utf8);
      CryptoService.validkey$.next(true);
    } catch (e) {
      console.log(e);
      CryptoService.validkey$.next(false);
    }
    return str;
  }

  static encrypt (msg: string) {
    let key = CryptoService.getKey();
    let ciphertext: any;
    try {
     ciphertext = CryptoJS.AES.encrypt(msg, key);
     CryptoService.validkey$.next(true);
    } catch (e) {
      console.log(e);
      CryptoService.validkey$.next(false);
    }
    return ciphertext ? ciphertext.toString() : null;
  }

}
