import { NgModule } from '@angular/core';
import { HttpModule, XHRBackend, RequestOptions } from '@angular/http';

import { HttpService } from './http/http.service';
import { AuthHttpService } from './auth-http/auth.http.service';

@NgModule({
  imports: [
    HttpModule
  ],
  declarations: [
  ],
  providers: [
    {
      provide: HttpService,
      useFactory: (backend: XHRBackend, options: RequestOptions) => {
        return new HttpService(backend, options)
      },
      deps: [ XHRBackend, RequestOptions]
    },
    {
      provide: AuthHttpService,
      useFactory: (backend: XHRBackend, options: RequestOptions) => {
        return new HttpService(backend, options)
      },
      deps: [ XHRBackend, RequestOptions]
    }
  ],
  exports: [
    HttpModule
  ]
})
export class ServicesModule { }
