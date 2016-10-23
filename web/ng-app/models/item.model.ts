import {CryptoService} from '../services/crypto.service';
// import {Serializable} from '../models/serializable.model';
import {ListModel} from './list.model';

interface IItemJSON {
  id: number;
  title: string;
  content: string;
  created_at: string;
  updated_at: string;
  list: any;
}

export class ItemModel {

  public id: number;
  public title: string;
  public content: string;
  public created_at: string;
  public updated_at: string;
  public list: any;

  constructor (public rawJson?: IItemJSON) {
    if (rawJson) {
      this.deserialize();
    }
  }

  deserialize () {
    this.id = this.rawJson.id;
    this.title = CryptoService.decrypt(this.rawJson.title);
    this.content = CryptoService.decrypt(this.rawJson.content);
    this.created_at = this.rawJson.created_at;
    this.updated_at = this.rawJson.updated_at;
    this.list = this.rawJson.list;
  }

}
