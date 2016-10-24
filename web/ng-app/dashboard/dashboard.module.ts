import { NgModule }     from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule }   from '@angular/forms';

import { DashboardRoutingModule } from './dashboard.routing.module';
import { DashboardComponent } from './dashboard.component';
import { DashboardHomeComponent } from './dashboard-home.component';
import { DashboardListItemsComponent } from './dashboard-list-items.component';
import { DashboardItemComponent } from './dashboard-item.component';
import { DashboardNewListComponent } from './dashboard-new-list.component';
import { DashboardEditListComponent } from './dashboard-edit-list.component';
import { DirectivesModule } from '../directives/directives.module';


@NgModule({
  imports: [
    CommonModule,
    DashboardRoutingModule,
    DirectivesModule,
    FormsModule,
  ],
  declarations: [
    DashboardComponent,
    DashboardHomeComponent,
    DashboardListItemsComponent,
    DashboardItemComponent,
    DashboardNewListComponent,
    DashboardEditListComponent,
  ],
  exports: [
    CommonModule,
    FormsModule
  ]
})

export class DashboardModule { }