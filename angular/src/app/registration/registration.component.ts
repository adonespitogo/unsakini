import { Component, OnInit } from '@angular/core';
import { Angular2TokenService } from 'angular2-token';

@Component({
  selector: 'app-registration',
  templateUrl: './registration.component.html',
  styleUrls: ['./registration.component.css']
})
export class RegistrationComponent implements OnInit {

  user: any;
  errors: any;
  success = false;

  constructor(public service: Angular2TokenService) {
    this.user = {
      name: '',
      email: '',
      password: '',
      password_confirmation: ''
    };
  }

  doSubmit () {
    this.service.registerAccount(this.user).subscribe(
      (res) => {
        this.success = true;
      },
      (res) => {
        if (res.status == 422) {
          this.errors = res.json().errors
        } else {
          this.errors = ['Something went wrong.']
        }
      }
    );
  }

  ngOnInit() {
  }

}
