import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { HttpModule } from '@angular/http';
import { Angular2TokenService, A2tUiModule } from 'angular2-token';

import { AppRoutesModule } from './app.routes.module';

import { AppComponent } from './app.component';
import { RegistrationComponent } from './registration/registration.component';

@NgModule({
  imports: [
    BrowserModule,
    FormsModule,
    HttpModule,
    AppRoutesModule,
    A2tUiModule,
  ],
  declarations: [
    AppComponent,
    RegistrationComponent
  ],
  providers: [
    Angular2TokenService,
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
