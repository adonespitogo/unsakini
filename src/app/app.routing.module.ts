import { NgModule }     from '@angular/core';
import { RouterModule } from '@angular/router';

import { LoginComponent } from './login/login.component';
import { LoginRouteGuard } from './login/login.route.guard';
import { RegisterComponent } from './register/register.component';
import { DashboardRouteGuard } from './dashboard/dashboard.route.guard';


@NgModule({
  imports: [
    RouterModule.forRoot(
      [
        {
          path: '',
          redirectTo: 'dashboard',
          pathMatch: 'full'
        }
      ]
    )
  ],
  exports: [
    RouterModule
  ],
  providers: []
})
export class AppRoutingModule {}
