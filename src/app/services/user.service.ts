import { Injectable }     from '@angular/core';
import {BehaviorSubject} from 'rxjs/BehaviorSubject';
import {Observable} from 'rxjs/Observable';
import 'rxjs/add/operator/map';
import 'rxjs/add/operator/catch';

import {UserModel} from '../models/user.model';
import {CryptoService} from './crypto.service';
import {HttpService} from './http.service';

@Injectable()

export class UserService {

  static currentUser: UserModel;
  public currentUser$: BehaviorSubject<UserModel> = new BehaviorSubject<UserModel>(new UserModel());
  private fetchingCurrentUserObservable: any;

  constructor (private http: HttpService) { }

  getCurrentUser (cached?: boolean): Observable<UserModel> {
    if (cached && UserService.currentUser) {
      return Observable.of(UserService.currentUser);
    } else {
      if (this.fetchingCurrentUserObservable) {
        return this.fetchingCurrentUserObservable;
      }
      this.fetchingCurrentUserObservable = new Observable<UserModel>((observable) => {
        this.http.get('/user').map(
          (res) => {
            return res.json();
          }
        ).subscribe((json) => {
          CryptoService.setKeyName(json);
          UserService.currentUser = new UserModel(json);
          observable.next(UserService.currentUser);
          observable.complete();
          this.currentUser$.next(UserService.currentUser);
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
