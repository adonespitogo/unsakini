
import {Component, OnInit} from '@angular/core';
import {Router, ActivatedRoute, Params} from '@angular/router';
import {Observable} from 'rxjs/Rx';
import 'rxjs/add/operator/map';
import 'rxjs/add/operator/catch';

import {AuthService} from '../services/auth.service';
import {CryptoService} from '../services/crypto.service';

interface IConfirmationParams {
  account_confirmation_success;
  client_id;
  config;
  expiry;
  token;
  uid;
}

@Component({
  templateUrl: './confirmation-success.html'
})
export class ConfirmationSuccessComponent implements OnInit{

  constructor(
    private route: ActivatedRoute,
    private router: Router
  ) {}

  ngOnInit() {
    this.route.queryParams.forEach((params: Params) => {
      console.log(params);
    });
  }
}
