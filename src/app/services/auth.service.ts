
import {Injectable} from '@angular/core';
import {BehaviorSubject} from 'rxjs/BehaviorSubject';
import {environment} from '../../environments/environment';

@Injectable()
export class AuthService {

  private static storageKey: string = window.btoa(environment.production ? 'production' : 'dev');
  private static authenticated: boolean;
  private static hasInit: boolean = false;
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
    if (authed !== AuthService.authenticated || !AuthService.hasInit) {
      AuthService.authenticated = authed;
      AuthService.authenticated$.next(authed);
    }
    if (!authed) {
      AuthService.removeToken();
    }
    if (!AuthService.hasInit) {
      AuthService.hasInit = true;
    }
  }

}
