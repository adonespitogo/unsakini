import { NgModule }     from '@angular/core';
import { RouterModule } from '@angular/router';

import { RegistrationComponent } from './registration/registration.component'


const routes = [
  {
    path: '',
    redirectTo: 'registration',
    pathMatch: 'full'
  },
  {
    path: 'registration',
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
