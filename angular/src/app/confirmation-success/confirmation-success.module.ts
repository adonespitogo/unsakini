import {NgModule} from '@angular/core';
import { RouterModule } from '@angular/router';
import { BrowserModule } from '@angular/platform-browser';
import { HttpModule } from '@angular/http';
import { FormsModule } from '@angular/forms';

import {ConfirmationSuccessComponent} from './confirmation-success.component';

@NgModule({
  imports: [
    BrowserModule,
    HttpModule,
    FormsModule,
    RouterModule.forRoot([
      {
        path: 'account/confirm',
        component: ConfirmationSuccessComponent,
      }
    ]),
  ],
  declarations: [
    ConfirmationSuccessComponent,
  ],
  providers: [
  ]
})

export class ConfirmationSuccessModule {}
