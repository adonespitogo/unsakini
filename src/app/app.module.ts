import { NgModule }      from '@angular/core';
import { RouterModule } from "@angular/router";
import { BrowserModule } from '@angular/platform-browser';
import { HttpModule, RequestOptions, ResponseOptions, Response } from '@angular/http';
import {ToasterService} from 'angular2-toaster/angular2-toaster';
import {ToasterModule} from 'angular2-toaster/angular2-toaster';
import {Ng2BreadcrumbModule, BreadcrumbService} from 'ng2-breadcrumb/ng2-breadcrumb';

import { AuthRequestOptions } from './services/auth.request.options';
import { AuthResponseOptions } from './services/auth.response.options';

import { AppComponent } from './app.component';
import { AppRoutingModule } from './app.routing';
import { DashboardModule } from './dashboard/dashboard.module';
import { SettingsModule } from './settings/settings.module';
import { LoginModule } from './login/login.module';
import { RegisterModule } from './register/register.module';

import { UserService } from './services/user.service';
import { ListService } from './services/list.service';
import { ItemService } from './services/item.service';

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
    Ng2BreadcrumbModule,
    LoginModule,
    RegisterModule,
  ],
  declarations: [
    AppComponent
  ],
  providers: [
    // CanActivateDashboard,
    // {provide: Response, useClass: AuthResponse},
    {provide: RequestOptions, useClass: AuthRequestOptions},
    {provide: ResponseOptions, useClass: AuthResponseOptions},
    ToasterService,
    UserService,
    ListService,
    ItemService,
    BreadcrumbService,
  ],
  bootstrap: [ AppComponent ],
  exports: [
    ToasterModule,
    Ng2BreadcrumbModule
  ]
})

export class AppModule { }
