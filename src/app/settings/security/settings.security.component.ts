import {Component, OnInit} from '@angular/core';
import {CryptoService} from '../../services/crypto.service';
import {ToasterService, BodyOutputType, Toast} from 'angular2-toaster/angular2-toaster';
import {Router} from '@angular/router';
import {AuthService} from '../../services/auth.service';

@Component({
  templateUrl: './settings.security.html'
})

export class SecuritySettingsComponent implements OnInit {
  public key: string = '';
  public keyConfirm: string = '';
  public showKey: boolean = false;
  public showKeyOnDelete: boolean = false;

  constructor (private toaster: ToasterService, private router: Router) {}

  ngOnInit () {
    this.key = CryptoService.getKey();
  }

  onSubmit () {
    CryptoService.setKey(this.key);
    let toast: Toast = {
      type: 'success',
      title: 'Private Key Saved',
      body: `Your private key has been successfully set in this browser.
        <b>You can navigate to the dashboard now</b>.
      `,
      bodyOutputType: BodyOutputType.TrustedHtml
    };
    this.toaster.pop(toast);
  }

  copied () {
    this.toaster.pop('success', 'Private Key Copied', 'Paste your private key somewhere else in case you forget it.');
  }

  deleteKey() {
    if (confirm(`Are you sure? Don't forget to make a copy of your key in case you forget it.`)) {
      AuthService.removeToken();
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
