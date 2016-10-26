import { Injectable }     from '@angular/core';
import { Http } from '@angular/http';

// import {Observable} from 'rxjs/Rx';
import 'rxjs/add/operator/map';
import 'rxjs/add/operator/catch';

import {UserModel} from '../models/user.model';

@Injectable()

export class UserService {

  static currentUser: UserModel;

  constructor (private http: Http) {
    this.getUser();
  }

  getUser () {
    return this.http.get('/user').map(
      (res) => {
        let user = new UserModel(res.json());
        UserService.currentUser = user;
        console.log(user);
        return user;
      }
    );
  }
}
