import {Injectable} from "@angular/core";
import {Http} from "@angular/http";
import {Observable} from 'rxjs/Rx';
import 'rxjs/add/operator/map';
import 'rxjs/add/operator/catch';

export interface ICredentials {
  email: string;
  password: string;
}

export interface IAuthUser {
  id: number,
  name: string,
  email: string
}

// export interface ILoginResponse {
//   token: string,
//   user:<IAuthUser>
// }

@Injectable()
export class LoginService {

  constructor (
    private http: Http
  ) {}

  login (creds: ICredentials) {
    return this.http.post('/login', creds).map(
      (res) => {
        return res.json();
      }
    );
  }
}
