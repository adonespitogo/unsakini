
import {Injectable} from '@angular/core';
import {Http, XHRBackend, RequestOptions, Request, RequestOptionsArgs, Response, Headers} from '@angular/http';
import {Observable} from 'rxjs/Observable';
import {AuthService} from './auth.service';
import {SlimLoadingBarService} from 'ng2-slim-loading-bar';

@Injectable()

export class HttpService extends Http {

  loader: SlimLoadingBarService;

  constructor (backend: XHRBackend, options: RequestOptions, loader: SlimLoadingBarService) {
    options.headers.set('Authorization', `Bearer ${AuthService.getAuthToken()}`);
    super(backend, options);
    this.loader = loader;
  }

  request(url: string|Request, options?: RequestOptionsArgs): Observable<Response> {
    if (typeof url === 'string') {
      if (!options) {
        options = {headers: new Headers()};
      }
      options.headers.set('Authorization', `Bearer ${AuthService.getAuthToken()}`);
    } else {
      url.headers.set('Authorization', `Bearer ${AuthService.getAuthToken()}`);
    }
    this.loader.start();
    return super.request(url, options).map((res: Response) => {
      this.loader.complete();
      AuthService.setAuthenticated({status: true, message: res});
      return res;
    })
    .catch(this.catchAuthError(this));
  }

  private catchAuthError (self: HttpService) {
    return (res: Response) => {
      self.loader.complete();
      if (res.status === 401 || res.status === 403) {
        AuthService.authenticated$.next({status: false, message: res});
      }
      return Observable.throw(res);
    };
  }

}
