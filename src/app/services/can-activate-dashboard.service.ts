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
          this.toaster.pop('error', 'Session expired! Please log in again.');
        }
      }
      this.loggedin = authed;
    });
  }

  private checkCryptoKey (): boolean {
    let key = CryptoService.getKey();
    if (!key) {
      this.router.navigate(['/settings']);
      this.toaster.pop('error', 'Please set your encryption key.');
      return false;
    }
    return true;
  }

  private isLoggedIn () {

    let token = localStorage.getItem('auth_token');
    if (!token || !this.loggedin) {
      this.router.navigate(['/login']);
      this.toaster.pop('error', 'Session expired! Please log in again.');
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

  ngOnDestroy () {
    this.authSubs.unsubscribe();
  }

}
