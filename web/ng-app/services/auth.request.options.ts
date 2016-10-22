
import {BaseRequestOptions} from '@angular/http';
declare var $:any;

export class AuthRequestOptions extends BaseRequestOptions {
    constructor() {
        super();
        var token = $.jStorage.get("auth_token");
        this.headers.append('Authorization', `Bearer ${token}`);
    }
}