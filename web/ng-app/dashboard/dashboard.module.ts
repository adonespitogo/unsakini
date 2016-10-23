import { NgModule }     from '@angular/core';
import { CommonModule } from '@angular/common';

import { DashboardRoutingModule } from './dashboard.routing.module';
import { DashboardComponent } from './dashboard.component';
import { DashboardHomeComponent } from './dashboard-home.component';
import { DashboardListItemsComponent } from './dashboard-list-items.component';
import { DashboardItemComponent } from './dashboard-item.component';

@NgModule({
  imports: [
    CommonModule,
    DashboardRoutingModule,
  ],
  declarations: [
    DashboardComponent,
    DashboardHomeComponent,
    DashboardListItemsComponent,
    DashboardItemComponent
  ],
})

export class DashboardModule { }