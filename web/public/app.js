var App = angular.module('kinsaka', [
  'ui.router',
])

.controller('TestDecryptCtrl', [
  '$scope',
  function ($scope) {
    var key = "My Secret Passphrase";
    var message = "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Non, eligendi similique delectus quaerat officiis reprehenderit, consectetur aliquid velit, sequi nisi hic magni voluptas. Deleniti maxime similique harum possimus veniam nesciunt.";
    var encryptedAES = CryptoJS.AES.encrypt(message, key);
    var encryptedAESString = encryptedAES.toString();

    var decrypted = CryptoJS.AES.decrypt(encryptedAESString, key);
    console.log(decrypted.toString(CryptoJS.enc.Utf8));

  }
]);