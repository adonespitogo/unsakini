import { NgModule }      from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { HttpModule, RequestOptions } from '@angular/http';
import { AuthRequestOptions } from '../services/auth.request.options';

import { AppComponent } from '../approot/approot.component';
import { AppRoutingModule } from './approot.routing.module';

import { DashboardModule } from '../dashboard/dashboard.module';
import { DirectivesModule } from '../directives/directives.module';

@NgModule({
  imports: [
    BrowserModule,
    HttpModule,
    AppRoutingModule,
    DashboardModule,
    DirectivesModule
  ],
  declarations: [
    AppComponent
  ],
  providers: [
    {provide: RequestOptions, useClass: AuthRequestOptions}
  ],
  bootstrap: [ AppComponent ]
})

export class AppModule { }