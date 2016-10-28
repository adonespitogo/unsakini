import { Injectable }     from '@angular/core';
import { Http } from '@angular/http';

// import {Observable} from 'rxjs/Rx';
import {BehaviorSubject} from 'rxjs/BehaviorSubject';
import {Observable} from 'rxjs/Observable';
import 'rxjs/add/operator/map';
import 'rxjs/add/operator/catch';

import {UserModel} from '../models/user.model';
// import {CryptoService} from './crypto.service';

@Injectable()

export class UserService {

  static currentUser: UserModel;
  public currentUser$: BehaviorSubject<UserModel> = new BehaviorSubject<UserModel>(new UserModel());

  constructor (private http: Http) { }

  getCurrentUser (cached?: boolean) {
    if (cached && UserService.currentUser) {
      this.currentUser$.next(UserService.currentUser);
      return Observable.of(UserService.currentUser);
    } else {
      return this.http.get('/user').map(
        (res) => {
          if (res) {
            UserService.currentUser = new UserModel(res.json());
            // CryptoService.setKeyName(`user_${UserService.currentUser.id}_crypto_key`);
            this.currentUser$.next(UserService.currentUser);
            return UserService.currentUser;
          }
          return new UserModel();
        }
      );
    }
  }

}
