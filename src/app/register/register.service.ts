import {Injectable} from '@angular/core';
import {Http} from '@angular/http';
import 'rxjs/add/operator/map';
import 'rxjs/add/operator/catch';


export interface IAuthUser {
  name: string;
  email: string;
  password: string;
  password_confirmation: string;
}

@Injectable()
export class RegisterService {

  constructor (private http: Http) {}

  submit (user: IAuthUser) {
    return this.http.post('/users', user).map(
      (res) => {
        return res.json();
      }
    );
  }
}
