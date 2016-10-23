import {CryptoService} from '../services/crypto.service';
// import {Serializable} from '../models/serializable.model';
import {ItemModel} from '../models/item.model';

interface IListJson {
  id: number;
  name: string;
  items: Array<any>;
}

export class ListModel {

  public id: number;
  public name: string;
  public items: Array<ItemModel>;

  constructor (public rawJson?: IListJson) {
    if (rawJson) {
      this.deserialize();
    }
  }

  deserialize () {
    this.id = this.rawJson.id;
    this.name = CryptoService.decrypt(this.rawJson.name);
    this.items = [];
    for (var i = this.rawJson.items.length - 1; i >= 0; i--) {
      var itemJson = this.rawJson.items[i];
      this.items[i] = new ItemModel(itemJson);
    }
  }


}