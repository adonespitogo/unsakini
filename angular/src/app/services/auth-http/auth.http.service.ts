
import { environment } from '../../../environments/environment';
import {HttpService} from '../http/http.service';
import {Injectable} from '@angular/core';
import {Http, XHRBackend, RequestOptions, Request, RequestOptionsArgs, Response, Headers} from '@angular/http';
import {Observable} from 'rxjs/Observable';
import 'rxjs/add/operator/catch';
import 'rxjs/add/operator/map';

@Injectable()
export class AuthHttpService extends HttpService {

  base_url = environment.api_base_url;

  constructor (backend: XHRBackend, options: RequestOptions) {
    super(backend, options);
  }

  request(url: string|Request, options?: RequestOptionsArgs): Observable<Response> {
    if (typeof url === 'string') {
      if (!options) {
        options = {headers: new Headers()};
      }
      options.headers.set('Authorization', `Bearer ${this.getAuthToken()}`);
    } else {
      url.headers.set('Authorization', `Bearer ${this.getAuthToken()}`);
    }
    return super.request(url, options);
  }

  getAuthToken () {
    return localStorage.getItem('auth_token');
  }

}