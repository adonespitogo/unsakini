import {NgModule} from '@angular/core';
import { RouterModule } from '@angular/router';
import { BrowserModule } from '@angular/platform-browser';
import { HttpModule } from '@angular/http';
import { FormsModule } from '@angular/forms';

import {LoginComponent} from './login.component';
import {LoginService} from './login.service';
import {LoginRouteGuard} from './login.route.guard';

@NgModule({
  imports: [
    BrowserModule,
    HttpModule,
    FormsModule,
    RouterModule.forRoot([
      {
        path: 'login',
        component: LoginComponent,
        canActivate: ['LoginRouteGuard'],
      }
    ]),
  ],
  declarations: [
    LoginComponent,
  ],
  providers: [
    LoginService,
    {
      provide: 'LoginRouteGuard',
      useClass: LoginRouteGuard
    }
  ]
})

export class LoginModule {}
