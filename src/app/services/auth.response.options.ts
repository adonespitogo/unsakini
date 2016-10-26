import {Injectable}      from '@angular/core';
import { BaseResponseOptions, ResponseOptionsArgs, ResponseOptions } from '@angular/http';

declare let localStorage: any;

@Injectable()
export class AuthResponseOptions extends BaseResponseOptions {

  merge(options?: ResponseOptionsArgs): ResponseOptions {
    if (options) {
      if (options.status) {
        if (options.status === 401 || options.status === 403) {
          if (window.location.href.indexOf('login') === -1 || window.location.href.indexOf('register') === -1) {
            console.log('Logged out');
          }
        }
      }
    }
    return super.merge(options);
  }
}
