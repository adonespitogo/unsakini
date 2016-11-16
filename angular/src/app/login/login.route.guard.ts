import {Injectable} from '@angular/core';
import {Router, CanActivate, ActivatedRouteSnapshot, RouterStateSnapshot} from '@angular/router';
import {Observable} from 'rxjs/Rx';
import { Angular2TokenService } from 'angular2-token';
import {AuthService} from '../services/auth.service';

@Injectable()
export class LoginRouteGuard implements CanActivate {

  constructor (private router: Router, private http: Angular2TokenService) {}

  canActivate(
    route: ActivatedRouteSnapshot,
    state: RouterStateSnapshot
  ): Observable<boolean>|boolean {
    return this.http.validateToken()
      .map((res) => {
        return !res.ok;
      })
      .catch((err:any) => {
        return Observable.of(true);
      });
  }

}
