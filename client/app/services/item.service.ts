import { Injectable }     from '@angular/core';
import { Http } from '@angular/http';

import {Observable} from 'rxjs/Rx';
import 'rxjs/add/operator/map';
import 'rxjs/add/operator/catch';

import {ListService} from "../services/list.service";
import {ItemModel} from "../models/item.model";
import {ListModel} from "../models/list.model";

@Injectable()

export class ItemService {

  constructor (private http: Http) { }

  static getCachedItem (id: number) {
    var lists = ListService.lists || [];
    for (var i = lists.length - 1; i >= 0; i--) {
      var list = lists[i];
      for (var i = list.items.length - 1; i >= 0; i--) {
        if (list.items[i].id === id) {
          return list.items[i];
        }
      }
    }
    return null;
  }

  getItem (id: number) {
    return this.http.get(`/items/${id}`).map(
      (res) => {
        var itemJson = res.json();
        var item = new ItemModel(itemJson);
        return item;
      }
    );
  }

  createItem (item) {
    return this.http.post('/items', item.serialize()).map(
      (res) => {
        var createdItem = new ItemModel(res.json());
        var list = ListService.getCachedList(createdItem.list_id);
        list.items.push(createdItem);
        return createdItem;
      }
    );
  }

  updateItem (item) {
    return this.http.put(`/items/${item.id}`, item.serialize()).map(
      (res) => {
        var list = ListService.getCachedList(item.list_id);
        for (var i = list.items.length - 1; i >= 0; i--) {
          if (list.items[i].id === item.id) {
            list.items[i] = item;
            break;
          }
        }
        return item;
      }
    );
  }

  deleteItem (item) {
    return this.http.delete(`/items/${item.id}`).map(
      () => {
        var list = ListService.getCachedList(item.list_id);
        for (var i = list.items.length - 1; i >= 0; i--) {
          if (list.items[i].id === item.id) {
            list.items.splice(i, 1);
            break;
          }
        }
      }
    );
  }

}