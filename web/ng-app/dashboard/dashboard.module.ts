import { NgModule }     from '@angular/core';

import { DashboardRoutingModule } from './dashboard.routing.module';
import { DashboardComponent } from './dashboard.component';
import { DashboardHomeComponent } from './dashboard-home.component';

@NgModule({
  imports: [
    DashboardRoutingModule,
  ],
  declarations: [
    DashboardComponent,
    DashboardHomeComponent
  ]
})

export class DashboardModule { }