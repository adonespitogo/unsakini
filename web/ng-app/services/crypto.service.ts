
declare var CryptoJS: any;

export class CryptoService {

  static decrypt (msg: string) {
    var key = '2538143';
    let bytes: any;
    try {
      bytes = CryptoJS.AES.decrypt(msg, key);
    } catch (e) {
    }
    if (bytes) {
      return bytes.toString(CryptoJS.enc.Utf8);
    } else {
      return msg;
    }
  }

  static encrypt (msg: string) {
    var key = '2538143';
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