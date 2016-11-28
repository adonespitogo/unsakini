import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { HttpModule } from '@angular/http';

import { AppRoutesModule } from './app.routes.module';
import { AppComponent } from './app.component';
import { RegistrationModule } from './registration/registration.module';
import { LoginModule } from './login/login.module';
import { ConfirmAccountModule } from './confirm-account/confirm-account.module';
import { DashboardModule } from './dashboard/dashboard.module';

@NgModule({
  imports: [
    BrowserModule,
    FormsModule,
    HttpModule,

    AppRoutesModule,
    RegistrationModule,
    ConfirmAccountModule,
    LoginModule,
    DashboardModule,
  ],
  declarations: [
    AppComponent
  ],
  providers: [
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
