import {CryptoService} from '../services/crypto.service';
import {ListService} from '../services/list.service';
import {ListModel} from './list.model';

interface IItemJSON {
  id: number;
  title: string;
  content: string;
  created_at: string;
  updated_at: string;
  list_id: number;
  list: any;
}

export class ItemModel {

  public id: number = 0;
  public title: string = '';
  public content: string = '';
  public created_at: string = '';
  public updated_at: string = '';
  public list: ListModel;
  public list_id: number = 0;

  constructor (public rawJson?: IItemJSON) {
    if (rawJson) {
      this.id = rawJson.id || 0;
      this.title = rawJson.title || '';
      this.content = rawJson.content || '';
      this.created_at = rawJson.created_at || '';
      this.updated_at = rawJson.updated_at || '';
      this.list_id = rawJson.list_id || 0;
      this.list = new ListModel(rawJson.list) || new ListModel();
    }
    this.deserialize();
  }

  deserialize () {
    this.title = CryptoService.decrypt(this.title);
    this.content = CryptoService.decrypt(this.content);
    this.list = this.getList();
  }

  serialize () {
    let l_id: number;
    let list = this.getList();
    if (list) {
      l_id = list.id;
    } else {
      throw `Item ${this.title} has no associated list!`;
    }
    return {
      id: this.id,
      title: CryptoService.encrypt(this.title),
      content: CryptoService.encrypt(this.content),
      created_at: this.created_at,
      updated_at: this.updated_at,
      list_id: l_id
    };
  }

  setList (list) {
    this.list = list;
  }

  getList () {
    if (this.list) {
      return this.list;
    } else if (this.list_id) {
      let lists = ListService.lists || [];
      for (let i = lists.length - 1; i >= 0; i--) {
        if (lists[i].id === this.list_id) {
          return lists[i];
        }
        return null;
      }
    } else {
      return null;
    }
  }

  copy () {
    let _list = this.getList() || new ListModel();
    let item = new ItemModel();
    item.id = this.id;
    item.title = this.title;
    item.content = this.content;
    item.created_at = this.created_at;
    item.updated_at = this.updated_at;
    item.list = _list;
    item.list_id = _list.id;
    return item;
  }

}
