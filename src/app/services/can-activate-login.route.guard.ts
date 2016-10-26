import {Injectable} from "@angular/core";
import {Router, CanActivate, ActivatedRouteSnapshot, RouterStateSnapshot} from "@angular/router";
import {Observable} from "rxjs/Rx";
import {CryptoService} from "./crypto.service";
// import {AuthResponseOptions} from "./auth.response.options";

@Injectable()
export class CanActivateLogin implements CanActivate {

  constructor (private router: Router) {}

  canActivate(
    route: ActivatedRouteSnapshot,
    state: RouterStateSnapshot
  ): Observable<boolean>|boolean {
    let can = !localStorage.getItem('auth_token');
    if (!can) {
      this.router.navigate(['/dashboard']);
    }
    return can;
    // return !!CryptoService.getKey();
  }
  
}
