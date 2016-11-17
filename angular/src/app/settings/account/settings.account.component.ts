import {Component} from '@angular/core';
import {Router} from '@angular/router';
import {UserModel} from '../../models/user.model';
import {AccountModel} from '../../models/account.model';
import {UserService} from '../../services/user.service';

import {Observable} from 'rxjs/Rx';
import 'rxjs/add/operator/map';
import 'rxjs/add/operator/catch';
import {ToasterService} from 'angular2-toaster/angular2-toaster';


@Component({
  templateUrl: './settings.account.html'
})

export class AccountSettingsComponent {

  public account: AccountModel;

  constructor(
    private router: Router,
    private userService: UserService,
    private toaster: ToasterService
  ) {
    this.account = new AccountModel(new UserModel());
    userService.getCurrentUser(true).subscribe((user: UserModel) => {
      this.account = new AccountModel(user);
    });
  }

  onSubmit () {
    this.userService.updateUser(this.account)
    .catch(this.updateUserFailed(this))
    .subscribe((user: UserModel) => {
      this.toaster.pop('success', 'Account Updated', 'Your profile has been updated successfully.');
      // this.account.confirm_password = '';
      // this.account.new_password = '';
      // this.account.old_password = '';
    });
  }

  passwordsValid () {
    let acct = this.account;
    if (acct.new_password.length > 0) {
      return acct.new_password === acct.confirm_password;
    }
    return true;
  }

  private updateUserFailed(self: AccountSettingsComponent) {
    return (res) => {
      let errors = res.json();
      for (let i = errors.length - 1; i >= 0; i--) {
        self.toaster.pop('error', `Update Failed`, errors[i].message);
      }
      return Observable.throw(res);
    };
  }

}
