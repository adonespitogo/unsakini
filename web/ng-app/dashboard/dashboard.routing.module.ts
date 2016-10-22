
import { NgModule }     from '@angular/core';
import { RouterModule } from '@angular/router';

import { DashboardComponent } from './dashboard.component';
import { DashboardHomeComponent } from './dashboard-home.component';

@NgModule({
  imports: [
    RouterModule.forChild([
      {
        path: 'dashboard',
        component: DashboardComponent,
        children: [
          {
            path: '',
            component: DashboardHomeComponent
          }
        ]
      }
    ])
  ],
  exports: [
    RouterModule
  ]
})
export class DashboardRoutingModule { }