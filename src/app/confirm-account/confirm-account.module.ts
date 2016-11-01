import {NgModule} from '@angular/core';
import {RouterModule, Router} from '@angular/router';
import {HttpModule} from '@angular/http';
import {ConfirmAccountComponent} from './confirm-account.component';
import {ConfirmAccountService} from './confirm-account.service';

@NgModule({
  imports: [
    HttpModule,
    RouterModule.forRoot([
      {
        path: 'user/confirm/:token',
        component: ConfirmAccountComponent
      }
    ])
  ],
  declarations: [
    ConfirmAccountComponent
  ],
  providers: [
    ConfirmAccountService
  ]
})

export class ConfirmAccountModule {}