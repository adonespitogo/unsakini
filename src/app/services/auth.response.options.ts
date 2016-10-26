import {Router} from '@angular/router';
import {Injectable}      from '@angular/core';
import {BaseResponseOptions, ResponseOptionsArgs, ResponseOptions} from '@angular/http';

declare var localStorage:any;

// import * as $ from "jquery";

@Injectable()
export class AuthResponseOptions extends BaseResponseOptions {

  /**
   * Creates a copy of the `ResponseOptions` instance, using the optional input as values to
   * override
   * existing values. This method will not change the values of the instance on which it is being
   * called.
   *
   * This may be useful when sharing a base `ResponseOptions` object inside tests,
   * where certain properties may change from test to test.
   *
   * ### Example ([live demo](http://plnkr.co/edit/1lXquqFfgduTFBWjNoRE?p=preview))
   *
   * ```typescript
   * import {ResponseOptions, Response} from '@angular/http';
   *
   * var options = new ResponseOptions({
   *   body: {name: 'Jeff'}
   * });
   * var res = new Response(options.merge({
   *   url: 'https://google.com'
   * }));
   * console.log('options.url:', options.url); // null
   * console.log('res.json():', res.json()); // Object {name: "Jeff"}
   * console.log('res.url:', res.url); // https://google.com
   * ```
   */
  merge(options?: ResponseOptionsArgs): ResponseOptions {
    if (options) {
      if (options.status) {
        if (options.status === 401 || options.status === 403) {
          if (!window.location.href.indexOf("login") && !window.location.href.indexOf("register")) {
            alert('Session expired! Please login again.');
            window.location.assign('/login');
          }
        }
      }
    }
    return super.merge(options);
  }
}
