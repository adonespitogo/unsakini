import {Component} from '@angular/core';
import {Router, Params, ActivatedRoute} from '@angular/router';
import {ConfirmAccountService} from './confirm-account.service';
import 'rxjs/add/operator/catch';

@Component({
  templateUrl: './confirm-account.html',
  styleUrls: ['./confirm-account.scss']
})

export class ConfirmAccountComponent {

  token = '';
  confirming = false;
  confirmed = false;
  has_error = false;

  constructor(
    private confirmAccountService: ConfirmAccountService,
    private router: Router
  ) {

  }

  doConfirm () {
    this.confirmAccountService.confirm(this.token).subscribe((confirmed) => {
      this.confirming = false;
      this.confirmed = confirmed;
    }, (res) => {
      this.confirming = false;
      this.has_error = true;
    });
  }

}
