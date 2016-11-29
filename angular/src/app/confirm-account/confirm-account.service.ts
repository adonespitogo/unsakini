import {Injectable} from '@angular/core';
import {Observable} from 'rxjs/Observable';
import 'rxjs/add/operator/map';
import 'rxjs/add/operator/catch';
import {HttpService} from '../services/http/http.service';

@Injectable()

export class ConfirmAccountService {
  constructor(private http: HttpService) { }

  confirm (token: string): Observable<any> {
    return this.http.post(`/users/confirm`, {token: token}).map((res) => {
      console.log(res)
      if (res.ok) {
        return true;
      } else {
        return false;
      }
    }).catch(this.catchError);
  }

  private catchError(res) {
    return Observable.throw(false);
  }

}
