
import { environment } from '../../../environments/environment';
import {Injectable} from '@angular/core';
import {Http, XHRBackend, RequestOptions, Request, RequestOptionsArgs, Response, Headers} from '@angular/http';
import {Observable} from 'rxjs/Observable';
import 'rxjs/add/operator/catch';
import 'rxjs/add/operator/map';

@Injectable()

export class HttpService extends Http {

  base_url = environment.api_base_url;

  constructor (backend: XHRBackend, options: RequestOptions) {
    super(backend, options);
  }

  getAuthToken (){
    localStorage.getItem('auth_token');
  }

  request(url: string|Request, options?: RequestOptionsArgs): Observable<Response> {
    if (typeof url === 'string') {
      url = this.buildUrl(url);
    } else {
      url.url = this.buildUrl(url.url);
    }
    return super.request(url, options);
  }

  buildUrl(url: string) {
    let new_url = `${this.base_url}/unsakini/${url}`;
    // remove multiple forward slash from the url like:
    // http://domain.com//hello/world -> http://domain.com/hello/world
    return new_url.replace(/([^:]\/)\/+/g, "$1").replace(/(^\/)\/+/g, "$1");
  }

}
