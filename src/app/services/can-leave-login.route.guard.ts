// import {Injectable} from "@angular/core";
// import {Router, CanDeactivate, ActivatedRouteSnapshot, RouterStateSnapshot} from "@angular/router";
// import {Observable} from "rxjs/Rx";
// import {CryptoService} from "./crypto.service";
// import {Http} from "@angular/http";
// // import {AuthResponseOptions} from "./auth.response.options";

// export interface CanComponentDeactivate {
//  canDeactivate: () => Observable<boolean> | boolean;
// }

// @Injectable()
// export class CanLeaveLogin implements CanDeactivate<CanComponentDeactivate> {

//   constructor (private router: Router, private http: Http) {}

//   canDeactivate(
//     // route: ActivatedRouteSnapshot
//   ): Observable<boolean>|boolean {
//     let token = localStorage.getItem('auth_token');
//     return true;
//     // return !!CryptoService.getKey();
//   }

// }
