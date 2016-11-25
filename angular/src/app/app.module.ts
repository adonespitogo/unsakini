import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { HttpModule } from '@angular/http';

import { AppRoutesModule } from './app.routes.module';

import { AppComponent } from './app.component';
import { RegistrationComponent } from './registration/registration.component';

@NgModule({
  imports: [
    BrowserModule,
    FormsModule,
    HttpModule,
    AppRoutesModule,
  ],
  declarations: [
    AppComponent,
    RegistrationComponent
  ],
  providers: [
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
