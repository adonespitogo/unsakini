import { NgModule }      from '@angular/core';
import { RouterModule } from '@angular/router';
import { BrowserModule } from '@angular/platform-browser';
import { HttpModule, RequestOptions, XHRBackend } from '@angular/http';
import {ToasterService} from 'angular2-toaster/angular2-toaster';
import {ToasterModule} from 'angular2-toaster/angular2-toaster';
import {SlimLoadingBarModule} from 'ng2-slim-loading-bar';


import { AppComponent } from './app.component';
import { AppRoutingModule } from './app.routing.module';
import { DashboardModule } from './dashboard/dashboard.module';
import { SettingsModule } from './settings/settings.module';
import { LoginModule } from './login/login.module';
import { RegisterModule } from './register/register.module';
import { ConfirmAccountModule } from './confirm-account/confirm-account.module';

import { HttpService } from './services/http.service';
import { UserService } from './services/user.service';
import { ListService } from './services/list.service';
import { ItemService } from './services/item.service';
import { AuthService } from './services/auth.service';
import { CryptoService } from './services/crypto.service';

declare var $: any;

@NgModule({
  imports: [
    BrowserModule,
    HttpModule,
    RouterModule,
    ToasterModule,
    AppRoutingModule,
    DashboardModule,
    SettingsModule,
    LoginModule,
    RegisterModule,
    ConfirmAccountModule,
    SlimLoadingBarModule.forRoot(),
  ],
  declarations: [
    AppComponent,
  ],
  providers: [
    ToasterService,
    UserService,
    ListService,
    ItemService,
    AuthService,
    CryptoService,
    {
      provide: HttpService,
      useFactory: (backend: XHRBackend, options: RequestOptions) => {
        return new HttpService(backend, options);
      },
      deps: [XHRBackend, RequestOptions]
    }
  ],
  bootstrap: [ AppComponent ],
  exports: [
  ]
})

export class AppModule { }
