import {Injectable}      from '@angular/core';
import { BaseResponseOptions, ResponseOptionsArgs, ResponseOptions } from '@angular/http';
import {AuthService} from './auth.service';

@Injectable()
export class AuthResponseOptions extends BaseResponseOptions {

  // listen for unauthorized requests
  merge(options?: ResponseOptionsArgs): ResponseOptions {
    let allowed = true;
    if (options) {
      if (options.status) {
        if (options.status === 401 || options.status === 403) {
          allowed = false;
          if (window.location.href.indexOf('login') === -1 || window.location.href.indexOf('register') === -1) {
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
    // update auth service status
    AuthService.setAuthenticated(allowed);
    return super.merge(options);
  }
}
