
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
    } catch (e) {
      console.log(e);
    }
    try {
      str = bytes.toString(CryptoJS.enc.Utf8);
    } catch (e) {
      console.log(e);
    }
    return str;
  }

  static encrypt (msg: string) {
    let key = CryptoService.getKey();
    let ciphertext: any;
    try {
     ciphertext = CryptoJS.AES.encrypt(msg, key);
    } catch (e) {
      console.log(e);
    }
    return ciphertext ? ciphertext.toString() : null;
  }

}
