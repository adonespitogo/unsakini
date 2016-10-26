import {NgModule} from '@angular/core';
import {RouterModule} from '@angular/router';
import { BrowserModule } from '@angular/platform-browser';
import { HttpModule } from '@angular/http';
import { FormsModule } from '@angular/forms';

import {RegisterComponent} from './register.component';
import {RegisterService} from './register.service';

@NgModule({
  imports: [
    RouterModule,
    BrowserModule,
    HttpModule,
    FormsModule,
  ],
  declarations: [
    RegisterComponent,
  ],
  providers: [
    RegisterService
  ]
})

export class RegisterModule {}
