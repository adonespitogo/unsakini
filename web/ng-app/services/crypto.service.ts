
declare var CryptoJS: any;

export class CryptoService {

  static decrypt (msg: string) {
    if (!msg) {
      return '';
    }
    var key = '2538143';
    var bytes = CryptoJS.AES.decrypt(msg, key);
    return bytes.toString(CryptoJS.enc.Utf8);
  }

  static encrypt (msg: string) {
    if (!msg) {
      return '';
    }
    var key = '2538143';
    var ciphertext = CryptoJS.AES.encrypt(msg, key);
    return ciphertext.toString();
  }
}