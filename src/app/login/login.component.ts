
import {Component} from '@angular/core';
import {Router} from '@angular/router';
import {ICredentials, LoginService} from './login.service';
import {Observable} from 'rxjs/Rx';
import 'rxjs/add/operator/map';
import 'rxjs/add/operator/catch';

import {AuthService} from '../services/auth.service';

@Component({
  templateUrl: './login.html'
})

export class LoginComponent {

  creds: ICredentials;
  error: string;
  success: string;

  constructor(
    private loginService: LoginService,
    private router: Router
  ) {
    this.creds = {email: '', password: ''};
  }

  doLogin (e) {
     e.stopPropagation();
    this.error = null;
    this.loginService.login(this.creds)
    .catch(this.loginFailedHandler(this))
    .subscribe(
      (json) => {
        this.success = 'Login successful. Redirecting...';
        AuthService.setAuthToken(json.token);
        AuthService.setAuthenticated(true);
        this.router.navigate(['/dashboard']);
      }
    );
    return false;
  }

  private loginFailedHandler (self: LoginComponent) {
    return (err: any) => {
      self.success = '';
      self.error = err.json().err || 'Invalid email and password combination.';
      return Observable.throw(err);
    };
  }
}
