import { Injectable }     from '@angular/core';
import { Http } from '@angular/http';

import {Observable} from 'rxjs/Rx';
import 'rxjs/add/operator/map';
import 'rxjs/add/operator/catch';

import {ListModel} from "../models/list.model";
import {ItemModel} from "../models/item.model";

@Injectable()

export class ListService {

  public lists: Array<ListModel>;

  constructor (private http: Http) { }

  getLists () {
    return this.http.get('/lists').map(
      (res) => {
        this.lists = [];
        let lists = res.json();
        for (var i = lists.length - 1; i >= 0; i--) {
          this.lists[i] = new ListModel(lists[i]);
        }
        return this.lists;
      }
    );
  }

  getList (id: number) {
    return this.http.get(`/lists/${id}`).map(
      (res) => {
        var listJson = res.json();
        var list = new ListModel(listJson);
        return list;
      }
    );
  }
}