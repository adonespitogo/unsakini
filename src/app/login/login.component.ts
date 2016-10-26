
import {Component} from '@angular/core';
import {Router} from '@angular/router';
import {ICredentials, LoginService} from './login.service';
import {ToasterService} from 'angular2-toaster/angular2-toaster';
import {Observable} from 'rxjs/Rx';
import 'rxjs/add/operator/map';
import 'rxjs/add/operator/catch';


@Component({
  // selector: 'login-app',
  templateUrl: './login.html'
})
export class LoginComponent {

  creds: ICredentials;
  error: string;
  success: string;

  constructor(
    private loginService: LoginService,
    private router: Router,
    private toaster: ToasterService
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
        window.localStorage.setItem('auth_token', json.token);
        this.router.navigate(['/dashboard']);
        this.toaster.pop('success', 'Login successful.');
      }
    );
    return false;
  }

  private loginFailedHandler (self: LoginComponent) {
    return (err: any) => {
      console.log(err);
      self.error = err.json().err || 'Invalid email and password combination.';
      return Observable.throw(err);
    };
  }
}
