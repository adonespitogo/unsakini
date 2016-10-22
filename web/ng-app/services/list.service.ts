import { Injectable }     from '@angular/core';
import { Http } from '@angular/http';

import {Observable} from 'rxjs/Rx';
import 'rxjs/add/operator/map';
import 'rxjs/add/operator/catch';

@Injectable()

export class ListService {

  constructor (private http: Http) { }

  getLists () {
    return this.http.get('/lists').map(
      (res) => { return res.json(); }
    );
  }
}