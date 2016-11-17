import { Injectable }     from '@angular/core';
import {BehaviorSubject} from 'rxjs/BehaviorSubject';
import {Observable} from 'rxjs/Observable';
import 'rxjs/add/operator/map';
import 'rxjs/add/operator/catch';

import {UserModel} from '../models/user.model';
import {CryptoService} from './crypto.service';
import {HttpService} from './http.service';
import {Angular2TokenService} from 'angular2-token';

@Injectable()

export class UserService {

  static currentUser: UserModel;
  public currentUser$: BehaviorSubject<UserModel> = new BehaviorSubject<UserModel>(new UserModel());
  private fetchingCurrentUserObservable: any;

  constructor (private http: Angular2TokenService) { }

  setCurrentUser (user) {
    UserService.currentUser = user;
    this.currentUser$.next(UserService.currentUser);
  }

  getCurrentUser (cached?: boolean): Observable<UserModel> {
    if (cached && UserService.currentUser) {
      return Observable.of(UserService.currentUser);
    } else {
      if (this.fetchingCurrentUserObservable) {
        return this.fetchingCurrentUserObservable;
      }
      this.fetchingCurrentUserObservable = new Observable<UserModel>((observable) => {
        this.http.get('user/0').map(
          (res) => {
          if (!CryptoService.keyName) {
            CryptoService.setKeyName(res.json());
          }
          UserService.currentUser = new UserModel(res.json());
          this.currentUser$.next(UserService.currentUser);
            return res.json();
          }
        ).subscribe((json) => {
          observable.next(UserService.currentUser);
          observable.complete();
          this.fetchingCurrentUserObservable = null;
          return UserService.currentUser;
        });
      });
      return this.fetchingCurrentUserObservable;
    }
  }

  updateUser (user) {
    return this.http.put('/user', user).map((res) => {
      console.log(res);
      UserService.currentUser = new UserModel(res.json());
      this.currentUser$.next(UserService.currentUser);
      return UserService.currentUser;
    });
  }

}
