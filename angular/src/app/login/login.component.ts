
import {Component} from '@angular/core';
import {Router} from '@angular/router';
import {ICredentials, LoginService} from './login.service';


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
    .subscribe(
      (json) => {
        this.success = 'Login successful. Redirecting...';
        window.localStorage.setItem('auth_token', json.token);
        // this.router.navigate(['/dashboard']);
        // window.location.assign('/dashboard');
      },
      (e) => {
        this.error = e;
      }
    );
    return false;
  }
}
