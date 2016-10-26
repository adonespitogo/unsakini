
import {BaseRequestOptions, RequestOptions, ResponseType, Headers, RequestOptionsArgs} from '@angular/http';
declare var localStorage:any;

export class AuthRequestOptions extends BaseRequestOptions {
    constructor() {
        let token = localStorage.getItem("auth_token");
        super();
        this.headers.set('Authorization', `Bearer ${token}`);
    }

    merge(options?: RequestOptionsArgs) : RequestOptions {
      var token = localStorage.getItem("auth_token");
      this.headers.set('Authorization', `Bearer ${token}`);
      return super.merge(options);
    }
}
