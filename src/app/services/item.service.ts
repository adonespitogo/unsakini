import { Injectable }     from '@angular/core';
import { Http } from '@angular/http';

// import {Observable} from 'rxjs/Rx';
import 'rxjs/add/operator/map';
import 'rxjs/add/operator/catch';

import {ListService} from '../services/list.service';
import {ItemModel} from '../models/item.model';
// import {ListModel} from '../models/list.model';

@Injectable()

export class ItemService {

  static getCachedItem (id: number) {
    let _lists = ListService.lists || [];
    for (let i = _lists.length - 1; i >= 0; i--) {
      let list = _lists[i];
      for (let x = list.items.length - 1; x >= 0; x--) {
        if (list.items[x].id === id) {
          return list.items[x];
        }
      }
    }
    return null;
  }

  constructor (private http: Http) { }

  getItem (id: number) {
    return this.http.get(`/items/${id}`).map(
      (res) => {
        let itemJson = res.json();
        let item = new ItemModel(itemJson);
        return item;
      }
    );
  }

  createItem (item) {
    return this.http.post('/items', item.serialize()).map(
      (res) => {
        let createdItem = new ItemModel(res.json());
        let list = ListService.getCachedList(createdItem.list_id);
        list.items.push(createdItem);
        return createdItem;
      }
    );
  }

  updateItem (item) {
    return this.http.put(`/items/${item.id}`, item.serialize()).map(
      (res) => {
        let list = ListService.getCachedList(item.list_id);
        for (let i = list.items.length - 1; i >= 0; i--) {
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
        let list = ListService.getCachedList(item.list_id);
        for (let i = list.items.length - 1; i >= 0; i--) {
          if (list.items[i].id === item.id) {
            list.items.splice(i, 1);
            break;
          }
        }
      }
    );
  }

}
