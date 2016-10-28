
import {BehaviorSubject} from 'rxjs/BehaviorSubject';

export class AuthService {

  private static storageKey: string;
    private static authenticated: boolean;
  public static authenticated$: BehaviorSubject<boolean> = new BehaviorSubject<boolean>(false);

  public static setStorageKey ({id}): void {
    AuthService.storageKey = window.btoa(`user_${id}_auth_key`);
  }

  public static setAuthToken (token: string) {
    localStorage.setItem(AuthService.storageKey, window.btoa(token));
  }

  public static getAuthToken (): string {
    let token: string = localStorage.getItem(AuthService.storageKey);
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
