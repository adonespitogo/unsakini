import {NgModule} from '@angular/core';
import { RouterModule } from '@angular/router';
import { BrowserModule } from '@angular/platform-browser';
import { HttpModule } from '@angular/http';
import { FormsModule } from '@angular/forms';

import {LoginComponent} from './login.component';
import {LoginService} from './login.service';

@NgModule({
  imports: [
    BrowserModule,
    HttpModule,
    FormsModule,
    RouterModule,
  ],
  declarations: [
    LoginComponent,
  ],
  providers: [
    LoginService
  ]
})

export class LoginModule {}
