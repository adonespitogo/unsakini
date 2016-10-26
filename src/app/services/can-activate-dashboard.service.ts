import {Injectable} from "@angular/core";
import {Router, CanActivate, ActivatedRouteSnapshot, RouterStateSnapshot, CanActivateChild} from "@angular/router";
import {Observable} from "rxjs/Rx";
import {CryptoService} from "./crypto.service";
import {ToasterService} from "angular2-toaster/angular2-toaster";
// import {AuthResponseOptions} from "./auth.response.options";

@Injectable()
export class CanActivateDashboard implements CanActivate, CanActivateChild {

  constructor (private router: Router, private toaster: ToasterService) {}

  private checkCryptoKey (): boolean {
    var key = CryptoService.getKey();
    if (!key) {
      this.router.navigate(['/settings']);
      this.toaster.pop('error', "Please set your encryption key.");
      return false;
    }
    return true;
  }

  private isLoggedIn () {
    let token = localStorage.getItem('auth_token');
    if (!token) {
      this.router.navigate(['/login']);
      this.toaster.pop('error', "Session expired! Please log in again.");
      return false;
    }
    return true;
  }

  canActivate(
    route: ActivatedRouteSnapshot,
    state: RouterStateSnapshot
  ): Observable<boolean>|boolean {
    if (this.isLoggedIn ()) {
      return this.checkCryptoKey();
    } else {
      return false;
    }

    // return !!CryptoService.getKey();
  }

  canActivateChild(
    route: ActivatedRouteSnapshot,
    state: RouterStateSnapshot
  ): Observable<boolean>|boolean {
    if (this.isLoggedIn ()) {
      return this.checkCryptoKey();
    } else {
      return false;
    }
  }

}
