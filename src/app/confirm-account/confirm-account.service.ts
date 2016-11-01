import {Injectable} from '@angular/core';
import {Http} from '@angular/http';
import {Observable} from 'rxjs/Observable';
import 'rxjs/add/operator/map';

@Injectable()

export class ConfirmAccountService {
  constructor(private http: Http) { }

  confirm (token: string): Observable<any> {
    return this.http.post(`/user/confirm`, {token: token}).map((res) => res.json());
  }

}
