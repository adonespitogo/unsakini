import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { HttpModule } from '@angular/http';

import { AppRoutesModule } from './app.routes.module';
import { AppComponent } from './app.component';
import { RegistrationModule } from './registration/'
import { LoginModule } from './login/login.module'

@NgModule({
  imports: [
    BrowserModule,
    FormsModule,
    HttpModule,

    AppRoutesModule,
    RegistrationModule,
    LoginModule,
  ],
  declarations: [
    AppComponent
  ],
  providers: [
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
