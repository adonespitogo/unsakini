
import {BaseRequestOptions, RequestOptions, RequestOptionsArgs} from '@angular/http';
import {AuthService} from './auth.service';
declare let localStorage: any;

export class AuthRequestOptions extends BaseRequestOptions {
    constructor() {
        let token = AuthService.getAuthToken();
        super();
        this.headers.set('Authorization', `Bearer ${token}`);
    }

    merge(options?: RequestOptionsArgs): RequestOptions {
      let token = AuthService.getAuthToken();
      this.headers.set('Authorization', `Bearer ${token}`);
      return super.merge(options);
    }
}
