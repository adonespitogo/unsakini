
import { NgModule }     from '@angular/core';
import { RouterModule } from '@angular/router';
import { LoginComponent } from './login/login.component';
import { RegisterComponent } from './register/register.component';

import { DashboardRouteGuard } from './dashboard/dashboard.route.guard';
import { LoginRouteGuard } from './login/login.route.guard';


@NgModule({
  imports: [
    RouterModule.forRoot(
      [
        {
          path: '',
          redirectTo: 'dashboard',
          canActivate: ['DashboardRouteGuard'],
          pathMatch: 'full'
        },
        {
          path: 'login',
          component: LoginComponent,
          canActivate: ['LoginRouteGuard'],
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
      provide: 'LoginRouteGuard', useClass: LoginRouteGuard
    }
  ]
})
export class AppRoutingModule {}
