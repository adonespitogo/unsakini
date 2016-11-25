import { NgModule } from '@angular/core';
import { HttpModule } from '@angular/http';

import { provideAuth } from 'angular2-jwt';
import { HttpService } from './http/http.service';

@NgModule({
  imports: [
    HttpModule
  ],
  declarations: [
  ],
  providers: [
  	HttpService
  ],
  exports: [
    HttpModule
  ]
})
export class ServicesModule { }
