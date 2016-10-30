import {Injectable} from '@angular/core';
import {Router, CanActivate, ActivatedRouteSnapshot, RouterStateSnapshot, CanActivateChild} from '@angular/router';
import {Observable, Subscription} from 'rxjs/Rx';
import {CryptoService, ICryptoObservable} from '../services/crypto.service';
import {ToasterService} from 'angular2-toaster/angular2-toaster';
import {AuthService, IAuthMessage} from '../services/auth.service';
import {UserService} from '../services/user.service';

@Injectable()
export class DashboardRouteGuard implements CanActivate, CanActivateChild {

  private cryptosubs: Subscription;
  private error: string = '';

  constructor (private router: Router, private toaster: ToasterService, private userService: UserService) { }

  private hasCryptoKey (): boolean {
    return !!CryptoService.getKey();
  }

  private hasAuthToken () {
    if (!AuthService.getAuthToken()) {
      return false;
    }
    return true;
  }

  private _canActivate() {

    // return true;

    if (!this.hasAuthToken()) {
      this.router.navigate(['/login']);
      this.toaster.pop('error', 'Athentication Error', 'Session expired.');
      return false;
    }
    if (!this.hasCryptoKey() || !CryptoService.valid) {
      this.router.navigate(['/settings/security']);
      this.toaster.pop(
        'error',
        'Set Private Key',
        `Please set your private key first to be able to access your data.`
      );
      return false;
    }
    return true;

    // return this.hasAuthToken() && this.hasCryptoKey();
    // return this.userService.getCurrentUser(true).map((user) => {
    //   if (!this.hasAuthToken() ) {
    //     this.router.navigate(['/login']);
    //     this.toaster.pop('error', 'Athentication Error', 'Session expired.');
    //     return false;
    //   } else {
    //     if (!this.hasCryptoKey()) {
    //       this.router.navigate(['/settings/security']);
    //       this.toaster.pop(
    //         'error',
    //         'Set Private Key',
    //         `Please set your private key first to be able to access your data.`
    //       );
    //       return false;
    //     }
    //   }
    //   return true;
    // });
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

}
