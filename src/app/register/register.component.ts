
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
  submitting: boolean = false;

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
    this.submitting = true;
    e.stopPropagation();
    this.error = null;
    this.registerService.submit(this.user)
    .catch(this.submitFailHandler(this))
    .subscribe(
      (json) => {
        this.submitting = false;
        this.success = `Registration successful.
          A confirmation email has been sent to your email ${this.user.email}.
          Please check your spam folder if you can't see it in your inbox.
        `;
      }
    );
    return false;
  }

  private submitFailHandler (self: RegisterComponent) {
    return (res: any) => {
      let err = res.json();
      let msg = [];
      for (let i = 0; i < err.length; ++i) {
        let em = err[i].message;
        if (em = 'email must be unique') {
          em = 'Email is already taken';
        }
        msg.push(em);
      }
      self.error = msg.join(',') || 'Cannot process your input.';
      self.submitting = false;
      return Observable.throw(err);
    };
  }
}
