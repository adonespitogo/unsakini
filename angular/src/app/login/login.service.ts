import {Injectable} from '@angular/core';
import 'rxjs/add/operator/map';
import 'rxjs/add/operator/catch';
import { Angular2TokenService } from 'angular2-token';

export interface ICredentials {
  email: string;
  password: string;
}

export interface IAuthUser {
  email: string;
  password: string;
}

@Injectable()
export class LoginService {

  constructor (
    private http: Angular2TokenService
  ) {}

  login (creds: ICredentials) {
    return this.http.signIn(creds).map(
      (res) => {
        return res.json().data;
      }
    );
  }
}
