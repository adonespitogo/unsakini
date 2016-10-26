import {Injectable} from '@angular/core';
import {Router, CanActivate, ActivatedRouteSnapshot, RouterStateSnapshot} from '@angular/router';
import {Observable} from 'rxjs/Rx';
// import {CryptoService} from './crypto.service';
import {Http} from '@angular/http';
// import {AuthResponseOptions} from './auth.response.options';

@Injectable()
export class CanActivateLogin implements CanActivate {

  constructor (private router: Router, private http: Http) {}

  canActivate(
    route: ActivatedRouteSnapshot,
    state: RouterStateSnapshot
  ): Observable<boolean>|boolean {
    let token = localStorage.getItem('auth_token');
    if (token) {
      let ret = this.http.get(`/auth/verify?token=${token}`).map((res) => {
        console.log(res);
        let notLoggedIn: boolean = (res.status !== 202);
        if (!notLoggedIn) {
          console.log('navigating to dashboard');
          this.router.navigate(['dashboard']);
        }
        return notLoggedIn;
        // return Observable.of();
        // return false;
      })
      .catch((res) => {
        return Observable.of(true);
      });
      ret.subscribe((res) => {
        console.log('subscriptions');
        console.log(res);
      });
      return ret;
      // .subscribe( (bol) => console.log(bol));
      // obs.subscribe((res) => {
      //   this.router.navigate(['/dashboard']);
      // });
      // return true;
    }
    return true;
    // return !!CryptoService.getKey();
  }

}
