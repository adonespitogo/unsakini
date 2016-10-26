
interface IUserJson {
  id: number;
  name: string;
  email: string;
  created_at: string;
  updated_at: string;
}

export class UserModel implements IUserJson {

  public id: number = 0;
  public name: string = '';
  public email: string;
  public created_at: string = '';
  public updated_at: string = '';

  constructor (public rawJson?: IUserJson) {
    if (rawJson) {
      this.deserialize();
    }
  }

  deserialize () {
    this.id = this.rawJson.id;
    this.name = this.rawJson.name;
    this.email = this.rawJson.email;
    this.created_at = this.rawJson.created_at;
    this.updated_at = this.rawJson.updated_at;
  }

}
