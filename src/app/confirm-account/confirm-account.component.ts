import {Component} from '@angular/core';
import {Router, Params, ActivatedRoute} from '@angular/router';
import {ConfirmAccountService} from './confirm-account.service';
import 'rxjs/add/operator/catch';

@Component({
  templateUrl: './confirm-account.html',
  styleUrls: ['./confirm-account.scss']
})

export class ConfirmAccountComponent {
  confirming = true;
  confirmed: boolean;
  constructor(
    private confirmAccountService: ConfirmAccountService,
    private router: Router,
    private route: ActivatedRoute
  ) {
    this.route.params.forEach((params: Params) => {
      let token = params['token'];
      confirmAccountService.confirm(token).subscribe((json) => {
        this.confirming = false;
        this.confirmed = json.confirmed;
      });
    });
  }
}
