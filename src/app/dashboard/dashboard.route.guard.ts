import {Injectable, OnDestroy} from '@angular/core';
import {Router, CanActivate, ActivatedRouteSnapshot, RouterStateSnapshot, CanActivateChild} from '@angular/router';
import {Observable, Subscription} from 'rxjs/Rx';
import {CryptoService, ICryptoObservable} from '../services/crypto.service';
import {ToasterService} from 'angular2-toaster/angular2-toaster';
import {AuthService, IAuthMessage} from '../services/auth.service';
import {UserService} from '../services/user.service';

@Injectable()
export class DashboardRouteGuard implements CanActivate, CanActivateChild, OnDestroy {

  private authSubs: Subscription;
  private cryptosubs: Subscription;
  private error: string = '';

  constructor (private router: Router, private toaster: ToasterService, private userService: UserService) {

    this.authSubs = AuthService.authenticated$.subscribe((res: IAuthMessage) => {
      let authed: boolean = res.status;
      if (!authed) {
        switch (res.message) {
          case 'UNAUTHORIZED':
            this.error = 'Session expired. Please login again.';
            break;
          case 'NEEDS_CONFIRMATION':
            this.error = `Your account needs confirmation.
                          Check your email for the confirmation link.`;
            break;

          default:
            break;
        }
        this.toaster.pop('error', 'Logged out', this.error);
        this.router.navigate(['/login']);
      } else {
        this.error = '';
      }
    });

    this.cryptosubs = CryptoService.validkey$.subscribe((val: ICryptoObservable) => {

      this._canActivate().subscribe((canNavigate: boolean) => {
        if (!val.status && canNavigate) {
          this.router.navigate(['/settings']);
          toaster.pop(
            'error',
            'Cryptographic Problem Encountered',
            `You might have entered the wrong private key. ${val.message}`
          );
        }
      });
    });
  }

  private hasCryptoKey (): boolean {
    let key = CryptoService.getKey();
    return !!key;
  }

  private hasAuthToken () {
    return !!AuthService.getAuthToken();
  }

  private _canActivate() {

    return this.userService.getCurrentUser(true).map((user) => {
      if (!this.hasAuthToken() ) {
        this.router.navigate(['/login']);
        this.toaster.pop('error', 'Logged out', 'Session expired.');
        return false;
      } else {
        if (!this.hasCryptoKey()) {
          this.router.navigate(['/settings']);
          this.toaster.pop(
            'error',
            'Set Private Key',
            `Please set your private key first to be able to access your data.`
          );
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
