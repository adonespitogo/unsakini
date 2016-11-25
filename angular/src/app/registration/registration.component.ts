import { Component, OnInit } from '@angular/core';
import { RegistrationService } from './registration.service';

@Component({
  selector: 'app-registration',
  templateUrl: './registration.component.html',
  styleUrls: ['./registration.component.css']
})
export class RegistrationComponent implements OnInit {

  user: any;
  errors: any;
  success = false;

  constructor(public service: RegistrationService) {
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
        this.success = false;
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
