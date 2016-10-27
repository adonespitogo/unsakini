import {Injectable, OnDestroy} from '@angular/core';
import {Router, CanActivate, ActivatedRouteSnapshot, RouterStateSnapshot, CanActivateChild} from '@angular/router';
import {Observable, Subscription} from 'rxjs/Rx';
import {CryptoService} from './crypto.service';
import {ToasterService} from 'angular2-toaster/angular2-toaster';
import {AuthResponseOptions} from './auth.response.options';

@Injectable()
export class CanActivateDashboard implements CanActivate, CanActivateChild, OnDestroy {

  private loggedin = true;
  private authSubs: Subscription;

  constructor (private router: Router, private toaster: ToasterService) {

    this.authSubs = AuthResponseOptions.auth$.subscribe((authed) => {
      if (!authed) {
        if (this.loggedin) {
          localStorage.removeItem('auth_token');
          this.router.navigate(['/login']);
          this.toaster.pop('error', 'Your session has expired. Please login again.');
        }
      }
      this.loggedin = authed;
    });
  }

  private hasCryptoKey (): boolean {
    let key = CryptoService.getKey();
    return !!key;
  }

  private isLoggedIn () {

    let token = localStorage.getItem('auth_token');
    if (!token || !this.loggedin) {
      return false;
    }
    return true;
  }

  private _canActivate() {
    if (!this.isLoggedIn() ) {
      this.router.navigate(['/login']);
      this.toaster.pop('error', 'Session expired');
      localStorage.removeItem('auth_token');
      this.loggedin = false;
      return false;
    } else {
      if (!this.hasCryptoKey()) {
        this.router.navigate(['/settings']);
        this.toaster.pop('error', 'Set your private key first.');
        return false;
      }
    }
    return true;
  }

  canActivate(
    route: ActivatedRouteSnapshot,
    state: RouterStateSnapshot
  ): Observable<boolean>|boolean {
    return this._canActivate();
  }

  canActivateChild(
    route: ActivatedRouteSnapshot,
    state: RouterStateSnapshot
  ): Observable<boolean>|boolean {
    return this._canActivate();
  }

  ngOnDestroy () {
    this.authSubs.unsubscribe();
  }

}
