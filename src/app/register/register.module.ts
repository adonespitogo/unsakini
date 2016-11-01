import {NgModule} from '@angular/core';
import {RouterModule} from '@angular/router';
import { HttpModule } from '@angular/http';
import { FormsModule } from '@angular/forms';
import {CommonModule} from '@angular/common';

import {RegisterComponent} from './register.component';
import {RegisterService} from './register.service';

@NgModule({
  imports: [
    RouterModule.forRoot(
      [
        {
          path: 'register',
          component: RegisterComponent
        }
      ]
    ),
    HttpModule,
    FormsModule,
    CommonModule,
  ],
  declarations: [
    RegisterComponent,
  ],
  providers: [
    RegisterService
  ]
})

export class RegisterModule {}
