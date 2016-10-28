
import {BehaviorSubject} from 'rxjs/BehaviorSubject';

import {environment} from '../../environments/environment';

export class AuthService {

  private static storageKey: string = window.btoa(environment.production? 'production' : 'dev');
    private static authenticated: boolean;
  public static authenticated$: BehaviorSubject<boolean> = new BehaviorSubject<boolean>(true);

  public static setAuthToken (token: string) {
    localStorage.setItem(AuthService.storageKey, window.btoa(token));
  }

  public static getAuthToken (): string {
    let token: string = localStorage.getItem(AuthService.storageKey);
    if (token == null) {
      return '';
    }
    return window.atob(token);
  }

  public static removeToken () {
    localStorage.removeItem(AuthService.storageKey);
  }

  public static setAuthenticated (authed: boolean) {
    if (authed !== AuthService.authenticated) {
      AuthService.authenticated = authed;
      AuthService.authenticated$.next(authed);
    }
    if (!authed) {
      AuthService.removeToken();
    }
  }

}
