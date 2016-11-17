import {Injectable} from '@angular/core';
import {Router, CanActivate, ActivatedRouteSnapshot, RouterStateSnapshot, CanActivateChild} from '@angular/router';
import {Observable} from 'rxjs/Rx';
import {CryptoService} from '../services/crypto.service';
import {ToasterService} from 'angular2-toaster/angular2-toaster';
import {AuthService} from '../services/auth.service';
import {UserService} from '../services/user.service';
import { Angular2TokenService } from 'angular2-token';

@Injectable()
export class DashboardRouteGuard implements CanActivate, CanActivateChild {

  constructor (
    private router: Router,
    private toaster: ToasterService,
    private userService: UserService,
    private tokenService: Angular2TokenService
  ) { }

  private hasCryptoKey (): boolean {
    return !!CryptoService.getKey();
  }

  private hasAuthToken () {
    return this.tokenService.canActivate();
  }

  private _canActivate(): Observable<boolean>|boolean {
    if (!this.hasAuthToken()) {
      this.router.navigate(['/login']);
      return false;
    }
    return this.userService.getCurrentUser(true).map((user) => {
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

}
