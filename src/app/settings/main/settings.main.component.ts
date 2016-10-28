import {Component} from '@angular/core';
import {CryptoService} from '../../services/crypto.service';
import {ToasterService} from 'angular2-toaster/angular2-toaster';
import {Router} from '@angular/router';

@Component({
  templateUrl: './settings.main.html'
})

export class SettingsMainComponent {
  public key;
  public showKey: boolean = false;
  public hideAlert: boolean = false;

  constructor (private toaster: ToasterService, private router: Router) {
    this.key = CryptoService.getKey();
  }

  onSubmit () {
    CryptoService.setKey(this.key);
    this.toaster.pop(
      'success',
      'Private Key Saved',
      'Your private key has been successfully set in this browser. You can navigate to the dashboard now.'
    );
  }

  // goToOldSource () {
  //   localStorage.removeItem('auth_token');
  //   localStorage.removeItem('crypto_key');
  //   window.location.assign('https://unsakini-old-algo.herokuapp.com');
  // }

  copied () {
    this.toaster.pop('success', 'Private Key Copied', 'Paste your private key somewhere else in case you forget it.');
  }

  deleteKey() {
    if (confirm(`Are you sure? Don't forget to make a copy of your key in case you forget it.`)) {
      localStorage.removeItem('auth_token');
      this.router.navigate(['/login']);
      this.toaster.pop(
        'success',
        'Private Key Deleted',
        `Your private key has been deleted from this browser.
        You were automatically logged out since you can't access your data without your key.`
      );
      CryptoService.removeKey();
    }
  }
}
