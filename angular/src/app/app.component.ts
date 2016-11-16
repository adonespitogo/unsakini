import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { ToasterConfig, ToasterService } from 'angular2-toaster/angular2-toaster';
import { AuthService, IAuthMessage } from './services/auth.service';
import { Angular2TokenService } from 'angular2-token';

@Component({
  selector: '[appRootComponent]',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent {

  private hasAuthError = false;

  public toasterconfig: ToasterConfig = new ToasterConfig({
    positionClass: 'toast-top-left'
  });

  constructor(
    private router: Router,
    private toaster: ToasterService,
    private _tokenService: Angular2TokenService
  ) {

    this._tokenService.init({
        apiPath:                    `${window.location.origin}/api`,

        signInPath:                 `auth/sign_in`,
        signInRedirect:             '/login',
        signInStoredUrlStorageKey:  null,

        signOutPath:                `auth/sign_out`,
        validateTokenPath:          `auth/validate_token`,

        registerAccountPath:        `auth/`,
        deleteAccountPath:          `auth/`,
        registerAccountCallback:    window.location.href,

        updatePasswordPath:         `auth/`,
        resetPasswordPath:          `auth/password`,
        resetPasswordCallback:      window.location.href,

        userTypes:                  null,

        globalOptions: {
            headers: {
                'Content-Type':     'application/json',
                'Accept':           'application/json'
            }
        }
    });

    // AuthService.authenticated$.subscribe((auth: IAuthMessage) => {
    //   if (!auth.status) {
    //     router.navigate(['/login']);
    //     if (!this.hasAuthError) {
    //       let errMsg: string;
    //       if (!AuthService.getAuthToken()) {
    //         errMsg = `Session already expired.`;
    //       } else {
    //         errMsg = `Invalid authentication token.`;
    //       }
    //       toaster.pop('error', 'Authentication Error', errMsg);
    //     }
    //   }
    //   this.hasAuthError = !auth;
    // });

  }
}
