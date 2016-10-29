import { NgModule }     from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule }   from '@angular/forms';
import { CollapseModule } from 'ng2-bootstrap/ng2-bootstrap';

import { DashboardRoutingModule } from './dashboard.routing.module';
import { DashboardComponent } from './dashboard.component';
import { DashboardHomeComponent } from './home/dashboard-home.component';
import { DashboardListItemsComponent } from './list-items/dashboard-list-items.component';
import { DashboardItemComponent } from './dashboard-item.component';
import { DashboardNewListComponent } from './new-list/dashboard-new-list.component';
import { DashboardEditListComponent } from './dashboard-edit-list.component';
import { DashboardAddItemComponent } from './dashboard-add-item.component';
import { DashboardEditItemComponent } from './dashboard-edit-item.component';
import { DirectivesModule } from '../directives/directives.module';
import { DashboardRouteGuard } from './dashboard.route.guard';


@NgModule({
  imports: [
    CommonModule,
    DashboardRoutingModule,
    DirectivesModule,
    FormsModule,
    CollapseModule,
  ],
  declarations: [
    DashboardComponent,
    DashboardHomeComponent,
    DashboardListItemsComponent,
    DashboardItemComponent,
    DashboardNewListComponent,
    DashboardEditListComponent,
    DashboardAddItemComponent,
    DashboardEditItemComponent,
  ],
  providers: [
    DashboardRouteGuard,
  ],
  exports: [
    CommonModule,
    FormsModule
  ]
})

export class DashboardModule { }
