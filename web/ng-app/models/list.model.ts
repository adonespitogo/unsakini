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

  constructor (private rawJson?: IListJson) {
    if (rawJson) {
      this.deserialize();
    }
  }

  deserialize () {
    this.id = this.rawJson.id;
    this.name = CryptoService.decrypt(this.rawJson.name);
    if (this.rawJson.items) {
      this.items = [];
      for (var i = this.rawJson.items.length - 1; i >= 0; i--) {
        var itemJson = this.rawJson.items[i];
        this.items[i] = new ItemModel(itemJson);
      }
    }
  }

  serialize () {
    this.name = CryptoService.encrypt(this.name);
    delete this.items;
    return JSON.parse(JSON.stringify(this));
  }


}