import {Injectable} from '@angular/core';
import {Router, CanActivate, CanActivateChild, ActivatedRouteSnapshot, RouterStateSnapshot} from '@angular/router';
import {Observable} from 'rxjs/Rx';
import {ToasterService} from 'angular2-toaster/angular2-toaster';
import {AuthService} from '../services/auth.service';
import {UserService} from '../services/user.service';

@Injectable()
export class SettingsRouteGuard implements CanActivate, CanActivateChild {

  constructor (
    private router: Router,
    private toaster: ToasterService,
    private userService: UserService
   ) {}

  private _canActivate(): boolean {
    return !!AuthService.getAuthToken();
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
