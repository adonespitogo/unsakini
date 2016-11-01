
import {Component} from '@angular/core';
import {Router} from '@angular/router';
import {ICredentials, LoginService} from './login.service';
import {Observable} from 'rxjs/Rx';
import 'rxjs/add/operator/map';
import 'rxjs/add/operator/catch';

import {AuthService} from '../services/auth.service';
import {CryptoService} from '../services/crypto.service';
import {ToasterService} from 'angular2-toaster';

@Component({
  templateUrl: './login.html'
})

export class LoginComponent {

  creds: ICredentials;
  error: string;
  submitting: boolean = false;

  constructor(
    private loginService: LoginService,
    private router: Router,
    private toaster: ToasterService
  ) {
    this.creds = {email: '', password: ''};
  }

  doLogin (e) {
    this.submitting = true;
     e.stopPropagation();
    this.error = '';
    this.loginService.login(this.creds)
    .catch(this.loginFailedHandler(this))
    .subscribe(
      (json) => {
        this.toaster.pop('success', 'Login Successful', 'Loading dashboard.');
        AuthService.setAuthToken(json.token);
        CryptoService.setKeyName(json.user);
        this.router.navigate(['/dashboard']);
        this.submitting = false;
      }
    );
    return false;
  }

  private loginFailedHandler (self: LoginComponent) {
    return (err: any) => {
      self.submitting = false;
      self.error = err.json().err || 'Invalid email and password combination.';
      return Observable.throw(err);
    };
  }
}
