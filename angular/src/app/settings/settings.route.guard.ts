import {Injectable} from '@angular/core';
import {Router, CanActivate, CanActivateChild, ActivatedRouteSnapshot, RouterStateSnapshot} from '@angular/router';
import {Observable} from 'rxjs/Rx';
import {ToasterService} from 'angular2-toaster/angular2-toaster';
import {AuthService} from '../services/auth.service';
import {UserService} from '../services/user.service';
import { Angular2TokenService } from 'angular2-token';

@Injectable()
export class SettingsRouteGuard implements CanActivate, CanActivateChild {

  constructor (
    private router: Router,
    private toaster: ToasterService,
    private userService: UserService,
    private tokenService: Angular2TokenService
   ) {}

  private _canActivate(): boolean {
    return !!this.tokenService.canActivate();
  }

  canActivate(
    route: ActivatedRouteSnapshot,
    state: RouterStateSnapshot
  ): Observable<boolean>|boolean {

    return this.userService.getCurrentUser(true).map(() => {
      let can = this._canActivate();
      if (!can) {
        this.router.navigate(['/login']);
        return false;
      }
      return true;
    });
  }

  canActivateChild (
    route: ActivatedRouteSnapshot,
    state: RouterStateSnapshot
  ): Observable<boolean>|boolean {
    return this.canActivate(route, state);
  }

}
