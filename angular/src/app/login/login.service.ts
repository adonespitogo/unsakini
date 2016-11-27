import {Injectable} from '@angular/core';
import { HttpService } from '../services/http';
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
    return this.http.post('/api/user_token', {auth: creds}).map(
      (res) => {
        return res.json();
      }
    );
  }
}
