import { NgModule }     from '@angular/core';
import { CommonModule } from '@angular/common';

import { DashboardRoutingModule } from './dashboard.routing.module';
import { DashboardComponent } from './dashboard.component';
import { DashboardHomeComponent } from './dashboard-home.component';
import { DashboardListItemsComponent } from './dashboard-list-items.component';
import { DashboardItemComponent } from './dashboard-item.component';
import { DashboardNewListComponent } from './dashboard-new-list.component';
import { DirectivesModule } from '../directives/directives.module';


@NgModule({
  imports: [
    CommonModule,
    DashboardRoutingModule,
    DirectivesModule,
  ],
  declarations: [
    DashboardComponent,
    DashboardHomeComponent,
    DashboardListItemsComponent,
    DashboardItemComponent,
    DashboardNewListComponent,
  ],
})

export class DashboardModule { }