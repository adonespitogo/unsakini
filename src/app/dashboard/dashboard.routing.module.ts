
import { NgModule }     from '@angular/core';
import { RouterModule } from '@angular/router';

import { DashboardComponent } from './dashboard.component';
import { DashboardHomeComponent } from './dashboard-home.component';
import { DashboardListItemsComponent } from './dashboard-list-items.component';
import { DashboardItemComponent } from './dashboard-item.component';
import { DashboardNewListComponent } from './dashboard-new-list.component';
import { DashboardEditListComponent } from './dashboard-edit-list.component';
import { DashboardAddItemComponent } from './dashboard-add-item.component';
import { DashboardEditItemComponent } from './dashboard-edit-item.component';
import { CanActivateDashboard } from '../services/can-activate-dashboard.service';

@NgModule({
  imports: [
    RouterModule.forChild([
      {
        path: 'dashboard',
        component: DashboardComponent,
        canActivateChild: ['CanActivateDashboard'],
        children: [
          {
            path: '',
            component: DashboardHomeComponent
          },
          {
            path: 'lists/:id',
            component: DashboardListItemsComponent
          },
          {
            path: 'new-list',
            component: DashboardNewListComponent
          },
          {
            path: 'lists/:id/edit',
            component: DashboardEditListComponent
          },
          {
            path: 'items/:id',
            component: DashboardItemComponent
          },
          {
            path: 'lists/:id/add-item',
            component: DashboardAddItemComponent
          },
          {
            path: 'items/:id/edit',
            component: DashboardEditItemComponent
          }
        ]
      }
    ])
  ],
  exports: [
    RouterModule
  ],
  providers: [
    {
      provide: 'CanActivateDashboard',
      useClass: CanActivateDashboard
    }
  ]
})
export class DashboardRoutingModule { }
