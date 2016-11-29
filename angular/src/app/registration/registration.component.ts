import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { RegistrationService } from './registration.service';

@Component({
  selector: 'app-registration',
  templateUrl: './registration.component.html',
  styleUrls: ['./registration.component.css']
})
export class RegistrationComponent implements OnInit {

  user: any;
  errors = {
    name: [],
    email: [],
    password: [],
    password_confirmation: []
  };
  success = false;

  constructor(private service: RegistrationService, private router: Router) {
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
        this.router.navigate(['account/confirm'])
      },
      (res) => {
        this.success = false;
        this.errors = res;
      }
    );
  }

  ngOnInit() {
  }

}
