import { NgModule }      from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { HttpModule, RequestOptions } from '@angular/http';
import { AuthRequestOptions } from './services/auth.request.options';

import { AppComponent } from './approot/app.component';
import { AppRoutingModule } from './app.routing.module';

import { DashboardModule } from './dashboard/dashboard.module';

@NgModule({
  imports: [
    BrowserModule,
    AppRoutingModule,
    HttpModule,
    DashboardModule
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