
import {Component} from '@angular/core';
import {Router} from '@angular/router';
import {Response} from '@angular/http';
import {ICredentials, LoginService} from './login.service';
import {Observable} from 'rxjs/Rx';
import 'rxjs/add/operator/map';
import 'rxjs/add/operator/catch';


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
        window.localStorage.setItem('auth_token', json.token);
        // this.router.navigate(['/dashboard']);
        // window.location.assign('/dashboard');
      }
    );
    return false;
  }

  private loginFailedHandler (self: LoginComponent) {
    return (err: Response) => {
      console.log(err.headers.keys())
      self.error = err.toString()

      if (err.status === 404 && err.text.length === 0)
        self.error = `Invalid email and password combination.`
      else
        self.error = `Uknown error occured. Please file a bug report at https://github.com/adonespitogo/unsakini/issues`

      return Observable.throw(err);
    };
  }
}
