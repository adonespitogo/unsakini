import {Injectable}      from '@angular/core';
import { BaseResponseOptions, ResponseOptionsArgs, ResponseOptions } from '@angular/http';
import {BehaviorSubject} from 'rxjs/BehaviorSubject';

declare let localStorage: any;

@Injectable()
export class AuthResponseOptions extends BaseResponseOptions {

  static auth$: BehaviorSubject<boolean> = new BehaviorSubject<boolean>(true);
  static authed: boolean = true;

  merge(options?: ResponseOptionsArgs): ResponseOptions {
    let allowed = true;
    if (options) {
      if (options.status) {
        if (options.status === 401 || options.status === 403) {
          allowed = false;
          if (window.location.href.indexOf('login') === -1 || window.location.href.indexOf('register') === -1) {
            localStorage.removeItem('auth_key');
            let allowedPaths = ['login', 'register'];
            for (let i = 0; i < allowedPaths.length; i ++) {
              if (location.href.indexOf(allowedPaths[i]) > -1) {
                allowed = true;
                break;
              }
            }

          }
        }
      }
    }
    if (AuthResponseOptions.authed !== allowed) {
      AuthResponseOptions.auth$.next(allowed);
    }
    AuthResponseOptions.authed = allowed;
    return super.merge(options);
  }
}
