
import { NgModule }     from '@angular/core';
import { RouterModule } from '@angular/router';
// import { CanActivateDashboard } from '../services/can-activate-dashboard.service';
import { SettingsComponent } from './settings/settings.component';
import { LoginComponent } from './login/login.component';
import { RegisterComponent } from './register/register.component';

import { CanActivateDashboard } from './services/can-activate-dashboard.service';
import { CanActivateLogin } from './services/can-activate-login.route.guard';


@NgModule({
  imports: [
    RouterModule.forRoot(
      [
        {
          path: '',
          redirectTo: 'dashboard',
          pathMatch: 'full',
          canActivate: ['CanActivateDashboard']
        },
        {
          path: 'login',
          component: LoginComponent,
          canActivate: ['CanActivateLogin']
        },
        {
          path: 'register',
          component: RegisterComponent
        }
      ]
    )
  ],
  exports: [
    RouterModule
  ],
  providers: [
    {
      provide: 'CanActivateDashboard', useClass: CanActivateDashboard
    },
    {
      provide: 'CanActivateLogin', useClass: CanActivateLogin
    }
  ]
})
export class AppRoutingModule {}
