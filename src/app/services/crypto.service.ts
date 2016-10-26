
import * as CryptoJS from 'crypto-js';
declare let localSto: any;

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
