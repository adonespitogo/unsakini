
import {Injectable} from '@angular/core';
import {Http, XHRBackend, RequestOptions, Request, RequestOptionsArgs, Response, Headers} from '@angular/http';
import {Observable} from 'rxjs/Rx';
import {AuthService} from './auth.service';

@Injectable()
export class HttpService extends Http {

  constructor (backend: XHRBackend, options: RequestOptions) {
    options.headers.set('Authorization', `Bearer ${AuthService.getAuthToken()}`);
    super(backend, options);
  }

  request(url: string|Request, options?: RequestOptionsArgs): Observable<Response> {
    if (typeof url === 'string') {
      if (options) {
        options.headers.set('Authorization', `Bearer ${AuthService.getAuthToken()}`);
      } else {
        options = {headers: new Headers()};
      }
      options.headers.set('Authorization', `Bearer ${AuthService.getAuthToken()}`);
    } else {
      url.headers.set('Authorization', `Bearer ${AuthService.getAuthToken()}`);
    }
    return super.request(url, options).map((res: Response) => {
      AuthService.setAuthenticated({status: true, message: res});
      return res;
    })
    .catch(this.catchAuthError(this));
  }

  private catchAuthError (self: HttpService) {
    return (res: Response) => {
      console.log(res);
      if (res.status === 401 || res.status === 403) {
        AuthService.authenticated$.next({status: false, message: res});
      }
      return Observable.throw(res);
    }
  }

}