import { Injectable } from '@angular/core';
import { Http, Response } from '@angular/http';
// import { Observable } from 'rxjs/Observable';
// import 'rxjs/add/operator/catch';
// import 'rxjs/add/operator/map';
import { environment } from '../../../environments/environment';

// export interface IAccount {
// 	name: string
// 	email: string
// 	password: string
// 	password_confirmation: string
// }

@Injectable()
export class HttpService {

  base_url = environment.api_base_url

  constructor(private http: Http) { }

  post (url: string, data: any) {
    return this.http.post(this.buildUrl(url), data);
  }

  put (url: string, data: any) {
    return this.http.put(this.buildUrl(url), data);
  }

  patch (url: string, data: any) {
    return this.http.patch(this.buildUrl(url), data);
  }

  get (url: string) {
    return this.http.get(this.buildUrl(url));
  }

  delete (url: string) {
    return this.http.delete(this.buildUrl(url));
  }

  private buildUrl(url: string) {
    let new_url = `${this.base_url}/${url}`;
    return new_url.replace(/([^:]\/)\/+/g, "$1").replace(/(^\/)\/+/g, "$1");
  }

  // registerAccount (acct: IAccount) {
  //   return this.http.post(`$`, acct).catch(this.handleError).map(this.extractData)
  // }
}
