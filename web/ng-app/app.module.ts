import { NgModule }      from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { HttpModule, RequestOptions } from '@angular/http';
import { AuthRequestOptions } from './services/auth.request.options';

import { AppComponent } from './components/app/app.component';
import { AppRoutingModule } from './routing.module';
import { DashboardComponent } from './components/dashboard/dashboard.component';

@NgModule({
  imports: [
    BrowserModule,
    AppRoutingModule,
    HttpModule
  ],
  declarations: [
    AppComponent,
    DashboardComponent
  ],
  providers: [
    {provide: RequestOptions, useClass: AuthRequestOptions}
  ],
  bootstrap: [ AppComponent ]
})

export class AppModule { }