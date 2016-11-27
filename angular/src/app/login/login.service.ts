import {Injectable} from '@angular/core';
import {Response} from '@angular/http';
import { HttpService } from '../services/http';
import {Observable} from 'rxjs/Observable';
import 'rxjs/add/operator/map';
import 'rxjs/add/operator/catch';

export interface ICredentials {
  email: string;
  password: string;
}

export interface IAuthUser {
  id: number;
  name: string;
  email: string;
}

@Injectable()
export class LoginService {

  constructor (
    private http: HttpService
  ) {}

  login (creds: ICredentials) {
    return this.http.post('/user_token', {auth: creds}).map(
      (res) => {
        return res.json();
      }
    )
    .catch(this.loginFailedHandler(this));
  }

  private loginFailedHandler (self: LoginService) {
    return (res: Response) => {
      let error_message = res.toString();

      if (res.status === 404 && res.text.length === 0)
        error_message = `Invalid email and password combination.`
      if (res.status === 401)
        error_message = res.json().message;

      return Observable.throw(error_message);

    };
  }
}
