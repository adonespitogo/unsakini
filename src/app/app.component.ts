import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { ToasterConfig, ToasterService } from 'angular2-toaster/angular2-toaster';
import { AuthService, IAuthMessage } from './services/auth.service';

@Component({
  selector: '[appRootComponent]',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {

  private hasAuthError = false;

  public toasterconfig: ToasterConfig = new ToasterConfig({
    positionClass: 'toast-top-left',
    timeout: 15000
  });

  constructor(
    private router: Router,
    private toaster: ToasterService
  ) {

    AuthService.authenticated$.subscribe((auth: IAuthMessage) => {
      if (!auth.status) {
        router.navigate(['/login']);
        if (!this.hasAuthError) {
          let errMsg: string;
          if (!AuthService.getAuthToken()) {
            errMsg = `Session already expired.`;
          } else {
            errMsg = `Invalid authentication token.`;
          }
          toaster.pop('error', 'Authentication Error', errMsg);
        }
      }
      this.hasAuthError = !auth;
    });

  }
}
