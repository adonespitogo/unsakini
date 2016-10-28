import {Injectable, OnDestroy} from '@angular/core';
import {Router, CanActivate, ActivatedRouteSnapshot, RouterStateSnapshot, CanActivateChild} from '@angular/router';
import {Observable, Subscription} from 'rxjs/Rx';
import {CryptoService, ICryptoObservable} from './crypto.service';
import {ToasterService} from 'angular2-toaster/angular2-toaster';
import {AuthResponseOptions} from './auth.response.options';
import {UserService} from './user.service';
// import {UserModel} from '../models/user.model';

@Injectable()
export class CanActivateDashboard implements CanActivate, CanActivateChild, OnDestroy {

  private loggedin = true;
  private authSubs: Subscription;
  private cryptosubs: Subscription;

  constructor (private router: Router, private toaster: ToasterService, private userService: UserService) {

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

    this.cryptosubs = CryptoService.validkey$.subscribe((val: ICryptoObservable) => {

      this._canActivate().subscribe((canNavigate: boolean) => {
        if (!val.status && canNavigate) {
          this.router.navigate(['/settings']);
          toaster.pop(
            'error',
            'Cryptographic Problem Encountered',
            `You might have entered the wrong private key. Error message: ${val.message}`
          );
        }
      });
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

    return this.userService.getCurrentUser(true).map((user) => {
      if (!this.isLoggedIn() ) {
        this.router.navigate(['/login']);
        this.toaster.pop('error', 'Session expired');
        localStorage.removeItem('auth_token');
        this.loggedin = false;
        return false;
      } else {
        if (!this.hasCryptoKey()) {
          this.router.navigate(['/settings']);
          this.toaster.pop('error', 'Private Key Unset', `Please set your private key first so to be able to access your data.`);
          return false;
        }
      }
      return true;
    });
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
    this.cryptosubs.unsubscribe();
  }

}
