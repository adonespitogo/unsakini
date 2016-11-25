import { Injectable } from '@angular/core';
import { Observable } from 'rxjs/Observable';
import { Response } from '@angular/http';
import 'rxjs/add/observable/of';
import 'rxjs/add/observable/throw';
import 'rxjs/add/operator/map';
import 'rxjs/add/operator/catch';
import { HttpService } from '../services/http/http.service';

export interface IAccount {
  name: string
  email: string
  password: string
  password_confirmation: string
}

@Injectable()
export class RegistrationService {

  constructor(private http: HttpService) {}

  registerAccount(acct: IAccount) {
    return this.http.post('/api/user', acct)
                    .map(this.extractData)
                    .catch(this.handleError)
  }

  private extractData (res) {
    return res.json()
  }

  private handleError(err: Response) {
    let errors: any;
    try {
      errors = err.json();
    } catch (e) {
      errors = [err.text]
    }
    return Observable.of(errors)
  }
  
}