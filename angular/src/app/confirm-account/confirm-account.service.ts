import {Injectable} from '@angular/core';
import {Observable} from 'rxjs/Observable';
import 'rxjs/add/operator/map';
import 'rxjs/add/operator/catch';
import {HttpService} from '../services/http/http.service';

@Injectable()

export class ConfirmAccountService {
  constructor(private http: HttpService) { }

  confirm (token: string): Observable<any> {
    return this.http.get(`/user/confirm/${token}`).map((res) => {
      console.log(res)
      if (res.ok) {
        return {confirmed: true}
      } else {
        return {confirmed: false}
      }
    }).catch(this.catchError);
  }

  private catchError(res) {
    return Observable.of({confirmed: false});
  }

}
