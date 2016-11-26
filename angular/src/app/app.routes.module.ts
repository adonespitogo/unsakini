import { NgModule }     from '@angular/core';
import { RouterModule } from '@angular/router';

import { RegistrationComponent } from './registration/registration.component'


const routes = [
  {
    path: '',
    redirectTo: 'login',
    pathMatch: 'full'
  },
  {
    path: 'signup',
    component: RegistrationComponent
  }
];

@NgModule({
  imports: [
    RouterModule.forRoot(routes)
  ],
  exports: [
    RouterModule
  ],
  providers: []
})

export class AppRoutesModule {}
