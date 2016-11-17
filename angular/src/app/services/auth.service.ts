
import {Injectable} from '@angular/core';
import {Response} from '@angular/http';
import {BehaviorSubject} from 'rxjs/BehaviorSubject';
import {environment} from '../../environments/environment';

export interface IAuthMessage {
  status: boolean;
  message: Response|string;
}

@Injectable()
export class AuthService {

  private static storageKey: string = window.btoa(environment.production ? 'production' : 'dev');
  private static authenticated: boolean;
  private static hasInit: boolean = false;
  public static authenticated$: BehaviorSubject<IAuthMessage> =
                new BehaviorSubject<IAuthMessage>({status: true, message: ''});

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

  public static setAuthenticated (res: IAuthMessage) {
    let authed: boolean = res.status;
    if (authed !== AuthService.authenticated || !AuthService.hasInit) {
      AuthService.authenticated = authed;
      AuthService.authenticated$.next(res);
    }
    if (!authed) {
      AuthService.removeToken();
    }
    if (!AuthService.hasInit) {
      AuthService.hasInit = true;
    }
  }

}
