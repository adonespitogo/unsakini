import {Injectable} from '@angular/core';
import {Router, CanActivate, ActivatedRouteSnapshot, RouterStateSnapshot} from '@angular/router';
import {Observable} from 'rxjs/Rx';
import {Http} from '@angular/http';
import {AuthService} from './auth.service';

@Injectable()
export class CanActivateLogin implements CanActivate {

  constructor (private router: Router, private http: Http) {}

  canActivate(
    route: ActivatedRouteSnapshot,
    state: RouterStateSnapshot
  ): Observable<boolean>|boolean {
    let token = AuthService.getAuthToken();
    if (token) {
      return this.http.get(`/auth/verify?token=${token}`).map((res) => {
        let notLoggedIn: boolean = (res.status !== 202);
        if (!notLoggedIn) {
          this.router.navigate(['dashboard']);
        }
        return notLoggedIn;
      })
      .catch((res) => {
        return Observable.of(true);
      });
    }
    return true;
  }

}
