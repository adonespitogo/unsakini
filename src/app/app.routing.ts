
import { NgModule }     from '@angular/core';
import { RouterModule } from '@angular/router';
import { LoginComponent } from './login/login.component';
import { RegisterComponent } from './register/register.component';

import { DashboardRouteGuard } from './dashboard/dashboard.route.guard';
import { CanActivateLogin } from './services/can-activate-login.route.guard';


@NgModule({
  imports: [
    RouterModule.forRoot(
      [
        {
          path: '',
          redirectTo: 'dashboard',
          // component: DashboardComponent,
          canActivate: ['DashboardRouteGuard'],
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
        }
      ]
    )
  ],
  exports: [
    RouterModule
  ],
  providers: [
    {
      provide: 'DashboardRouteGuard', useClass: DashboardRouteGuard
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
