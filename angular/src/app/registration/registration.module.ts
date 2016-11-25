import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ServicesModule } from '../services'
import { RegistrationComponent } from './registration.component';
import { RegistrationService } from './registration.service';

@NgModule({
  imports: [
    ServicesModule,
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
