import { Injectable }     from '@angular/core';
import { Http } from '@angular/http';

import {Observable} from 'rxjs/Rx';
import 'rxjs/add/operator/map';
import 'rxjs/add/operator/catch';

// import {ListModel} from "../models/list.model";
import {ItemModel} from "../models/item.model";

@Injectable()

export class ItemService {

  constructor (private http: Http) { }

  getItem (id: number) {
    return this.http.get(`/items/${id}`).map(
      (res) => {
        var itemJson = res.json();
        var item = new ItemModel(itemJson);
        return item;
      }
    );
  }
}