import { NgModule }     from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule }   from '@angular/forms';
// import {Ng2BreadcrumbModule, BreadcrumbService} from 'ng2-breadcrumb/ng2-breadcrumb';
import { CollapseModule } from 'ng2-bootstrap/ng2-bootstrap';
import { SidebarModule } from 'ng2-sidebar';

import { DashboardRoutingModule } from './dashboard.routing.module';
import { DashboardComponent } from './dashboard.component';
import { DashboardHomeComponent } from './dashboard-home.component';
import { DashboardListItemsComponent } from './dashboard-list-items.component';
import { DashboardItemComponent } from './dashboard-item.component';
import { DashboardNewListComponent } from './dashboard-new-list.component';
import { DashboardEditListComponent } from './dashboard-edit-list.component';
import { DashboardAddItemComponent } from './dashboard-add-item.component';
import { DashboardEditItemComponent } from './dashboard-edit-item.component';
import { DirectivesModule } from '../directives/directives.module';
// import { CanActivateDashboard } from '../services/can-activate-dashboard.service';


@NgModule({
  imports: [
    CommonModule,
    DashboardRoutingModule,
    DirectivesModule,
    FormsModule,
    // Ng2BreadcrumbModule,
    CollapseModule,
    SidebarModule,
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
    // BreadcrumbService,
    // CanActivateDashboard
  ],
  exports: [
    CommonModule,
    FormsModule
  ]
})

export class DashboardModule { }
