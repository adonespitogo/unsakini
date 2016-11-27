import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { RouterModule } from '@angular/router';
import { ServicesModule } from '../services'
import { RegistrationComponent } from './registration.component';
import { RegistrationService } from './registration.service';

@NgModule({
  imports: [
    ServicesModule,
    RouterModule,
    FormsModule,
    CommonModule
  ],
  declarations: [
    RegistrationComponent
  ],
  providers: [
    RegistrationService
  ]
})
export class RegistrationModule { }
