import {NgModule} from '@angular/core';
import {RouterModule} from '@angular/router';
import {HttpModule} from '@angular/http';
import {CommonModule} from '@angular/common';
import {ServicesModule} from '../services/services.module';
import {ConfirmAccountComponent} from './confirm-account.component';
import {ConfirmAccountService} from './confirm-account.service';

@NgModule({
  imports: [
    HttpModule,
    RouterModule,
    CommonModule,
    ServicesModule,
  ],
  declarations: [
    ConfirmAccountComponent
  ],
  providers: [
    ConfirmAccountService
  ]
})

export class ConfirmAccountModule {}
