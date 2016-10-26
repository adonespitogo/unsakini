
import { NgModule }     from '@angular/core';
import { RouterModule } from '@angular/router';
// import { CanActivateDashboard } from '../services/can-activate-dashboard.service';
// import { SettingsComponent } from './settings/settings.component';
import { LoginComponent } from './login/login.component';
import { RegisterComponent } from './register/register.component';
// import { NotFoundComponent } from './not.found.component';
// import {DashboardComponent} from "./dashboard/dashboard.component";

import { CanActivateDashboard } from './services/can-activate-dashboard.service';
import { CanActivateLogin } from './services/can-activate-login.route.guard';
// import { CanLeaveLogin } from './services/can-leave-login.route.guard';


@NgModule({
  imports: [
    RouterModule.forRoot(
      [
        {
          path: '',
          redirectTo: 'dashboard',
          // component: DashboardComponent,
          canActivate: ['CanActivateDashboard'],
          pathMatch: 'full'
        },
        {
          path: 'login',
          component: LoginComponent,
          canActivate: ['CanActivateLogin'],
          // canDeactivate: ['CanLeaveLogin'],
        },
        {
          path: 'register',
          component: RegisterComponent
        },
        // {
        //   path: '**',
        //   component: NotFoundComponent,
        //   pathMatch: 'full'
        // }
      ],
      {
        useHash: true
      }
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
    },
    // {
    //   provide: 'CanLeaveLogin', useClass: CanLeaveLogin
    // }
  ]
})
export class AppRoutingModule {}
