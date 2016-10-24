
import { NgModule }     from '@angular/core';
import { RouterModule } from '@angular/router';

import { DashboardComponent } from './dashboard.component';
import { DashboardHomeComponent } from './dashboard-home.component';
import { DashboardListItemsComponent } from './dashboard-list-items.component';
import { DashboardItemComponent } from './dashboard-item.component';
import { DashboardNewListComponent } from './dashboard-new-list.component';
import { DashboardEditListComponent } from './dashboard-edit-list.component';

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