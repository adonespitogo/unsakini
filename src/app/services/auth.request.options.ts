
import {BaseRequestOptions} from '@angular/http';
declare var localStorage:any;

// import * as $ from "jquery";

export class AuthRequestOptions extends BaseRequestOptions {
    constructor() {
        super();
        var token = localStorage.getItem("auth_token");
        this.headers.append('Authorization', `Bearer ${token}`);
    }
}
