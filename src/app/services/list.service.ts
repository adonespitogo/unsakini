import { Injectable }     from '@angular/core';
import { Http } from '@angular/http';

import {Observable} from 'rxjs/Rx';
import 'rxjs/add/operator/map';
import 'rxjs/add/operator/catch';

declare let _: any;

import {ListModel} from '../models/list.model';

@Injectable()

export class ListService {

  static lists: Array<ListModel>;

  static getCachedList (id: number) {
    if (!ListService.lists) {
      return null;
    }
    for (let i = ListService.lists.length - 1; i >= 0; i--) {
      if (ListService.lists[i].id === id) {
        return ListService.lists[i];
      }
    }
    return null;
  }

  constructor (private http: Http) {}

  getLists () {
    return this.http.get('/lists').map(
      (res) => {
        ListService.lists = [];
        let lists = res.json();
        for (let i = lists.length - 1; i >= 0; i--) {
          ListService.lists[i] = new ListModel(lists[i]);
        }
        return ListService.lists;
      }
    );
  }

  getList (id: number) {
    return this.http.get(`/lists/${id}`).map(
      (res) => {
        let list = new ListModel(res.json());
        for (let i = ListService.lists.length - 1; i >= 0; i--) {
          if (ListService.lists[i].id === list.id) {
            ListService.lists[i] = list;
            break;
          }
        }
        return list;
      }
    )
    .catch(this.handleError);
  }

  getCachedList (id: number) {
    return ListService.getCachedList(id);
  }

  createList (list: ListModel) {
    return this.http.post('/lists', list.serialize()).map(
      (res) => {
        let newList = new ListModel(res.json());
        ListService.lists.push(newList);
        return newList;
      }
    );
  }

  updateList (list: ListModel) {
    return this.http.put(`/lists/${list.id}`, list.serialize()).map(
      (res) => {
        for (let i = ListService.lists.length - 1; i >= 0; i--) {
          if (ListService.lists[i].id === list.id) {
            ListService.lists[i] = list;
            break;
          }
        }
        return list;
      }
    )
    .catch(this.removeFromListsErrorCB(this, list));
  }

  deleteList (list: ListModel) {
    return this.http.delete(`/lists/${list.id}`).map(this._removeFromLists(list));
  }

  private _removeFromLists (list) {
    return (res) => {
      for (let i = ListService.lists.length - 1; i >= 0; i--) {
        if (ListService.lists[i].id === list.id) {
          ListService.lists.splice(i, 1);
          break;
        }
      }
    };
  }

  private removeFromListsErrorCB (self: ListService, list: ListModel) {
    return (err) => {
      self._removeFromLists(list)(err);
      return Observable.throw(err);
    };
  }

  private handleError (error: any) {
    // In a real world app, we might use a remote logging infrastructure
    // We'd also dig deeper into the error to get a better message
    let errMsg = (error.message) ? error.message :
      error.status ? `${error.status} - ${error.statusText}` : 'Server error';
    return Observable.throw(errMsg);
  }
}
