import { NgModule }     from '@angular/core';
import { RouterModule } from '@angular/router';

import { RegistrationComponent } from './registration/registration.component'
import { LoginComponent } from './login/login.component'


const routes = [
  {
    path: '',
    redirectTo: 'login',
    pathMatch: 'full'
  },
  {
    path: 'signup',
    component: RegistrationComponent
  },
  {
    path: 'login',
    component: LoginComponent
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
