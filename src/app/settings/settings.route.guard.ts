import {Injectable} from '@angular/core';
import {Router, CanActivate, ActivatedRouteSnapshot, RouterStateSnapshot} from '@angular/router';
import {Observable} from 'rxjs/Rx';
import {ToasterService} from 'angular2-toaster/angular2-toaster';
import {AuthService} from '../services/auth.service';

@Injectable()
export class SettingsRouteGuard implements CanActivate {

  constructor (
    private router: Router,
    private toaster: ToasterService
   ) {}

  private _canActivate(): boolean {
    return !!AuthService.getAuthToken();
  }

  canActivate(
    route: ActivatedRouteSnapshot,
    state: RouterStateSnapshot
  ): Observable<boolean>|boolean {
    let can = this._canActivate();
    if (!can) {
      this.router.navigate(['/login']);
      return false;
    }
    return true;
  }

}
