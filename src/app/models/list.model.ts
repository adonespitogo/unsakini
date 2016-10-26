import {CryptoService} from '../services/crypto.service';
// import {Serializable} from '../models/serializable.model';
import {ItemModel} from '../models/item.model';
import {UserService} from '../services/user.service';

interface IListJson {
  id: number;
  name: string;
  items: Array<any>;
}

export class ListModel implements IListJson {

  public id: number;
  public name: string;
  public items: Array<ItemModel>;

  constructor (rawJson?: IListJson) {
    if (rawJson) {
      this.id = rawJson.id || 0;
      this.name = rawJson.name || '';
      this.items = rawJson.items || [];
    } else {
      this.id = 0;
      this.name = '';
      this.items = [];
    }

    this.deserialize();
  }

  deserialize () {
    this.id = this.id;
    this.name = CryptoService.decrypt(this.name);
    if (this.items) {
      for (var i = this.items.length - 1; i >= 0; i--) {
        var itemJson = this.items[i];
        this.items[i] = new ItemModel(itemJson);
      }
    }
    return this;
  }

  serialize () {
    var items = [];
    for (var i = this.items.length - 1; i >= 0; i--) {
      items[i] = this.items[i].serialize();
    }
    return {
      id: this.id,
      name: CryptoService.encrypt(this.name),
      items: items
    };
  }

  copy () {
    var list = new ListModel();
    list.id = this.id;
    list.name = this.name;
    for (var i = this.items.length - 1; i >= 0; i--) {
      list.items[i] = this.items[i].copy();
    }
    return list;
  }

  applyValuesTo (list: ListModel) {
    list.id = this.id;
    list.name = this.name;
    list.items = this.items;
  }

  // toJSON () {
  //   return {
  //     id: this.id,
  //     name: this.name,
  //     items: this.items
  //   };
  // }


}