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
            localStorage.removeItem('auth_key');
            let allowedPaths = ['login', 'register'];
            let allowed = false;
            for (let i = 0; i < allowedPaths.length; i ++) {
              if (location.href.indexOf(allowedPaths[i]) > -1) {
                allowed = true;
                break;
              }
            }
            if (!allowed) {
              location.assign('/login');
            }
          }
        }
      }
    }
    return super.merge(options);
  }
}
