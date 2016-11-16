
import {UserModel} from './user.model';

export class AccountModel {

  id: number;
  name: string;
  email: string;
  old_password: string;
  new_password: string;
  confirm_password: string;

  constructor (user: UserModel) {
    this.id = user.id;
    this.name = user.name;
    this.email = user.email;
    this.old_password = '';
    this.new_password = '';
    this.confirm_password = '';
  }

}
