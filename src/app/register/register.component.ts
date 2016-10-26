
import {Component} from '@angular/core';
import {Router} from '@angular/router';
import {IAuthUser, RegisterService} from './register.service';
import {Observable} from 'rxjs/Rx';
import 'rxjs/add/operator/map';
import 'rxjs/add/operator/catch';


@Component({
  templateUrl: './register.html'
})
export class RegisterComponent {

  user: IAuthUser;
  error: string;
  success: string;

  constructor(
    private registerService: RegisterService,
    private router: Router
  ) {
    this.user = {
      name: '',
      email: '',
      password: '',
      password_confirmation: '',
    };
  }


  doSubmit (e) {
    console.log(e);
    e.stopPropagation();
    this.error = null;
    this.registerService.submit(this.user)
    .catch(this.submitFailHandler(this))
    .subscribe(
      (json) => {
        this.success = 'Registration successful.';
      }
    );
    return false;
  }

  private submitFailHandler (self: RegisterComponent) {
    return (res: any) => {
      let err = res.json();
      let msg = [];
      for (let i = 0; i < err.length; ++i) {
        msg.push(err[i].message);
      }
      self.error = msg.join(',') || 'Cannot process your input.';
      return Observable.throw(err);
    };
  }
}
