import { Injectable } from '@angular/core';
import { Http, Response } from '@angular/http';
import { Observable } from 'rxjs/Observable';
import 'rxjs/add/operator/catch';
import 'rxjs/add/operator/map';

export interface IAccount {
	name: string
	email: string
	password: string
	password_confirmation: string
}

@Injectable()
export class HttpService {

  constructor(private http: Http) { }

  registerAccount (acct: IAccount) {
  	return this.http.post('/', acct).catch(this.handleError).map(this.extractData)
  }

  private extractData(res: Response) {
    return res.json();
  }

  private handleError(res: Response) {
  	return Observable.throw(res.json())
  }

}
