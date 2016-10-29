
import { NgModule }     from '@angular/core';
import { RouterModule } from '@angular/router';

import { DashboardComponent } from './dashboard.component';
import { DashboardHomeComponent } from './home/dashboard-home.component';
import { DashboardListItemsComponent } from './list-items/dashboard-list-items.component';
import { DashboardItemComponent } from './dashboard-item.component';
import { DashboardNewListComponent } from './new-list/dashboard-new-list.component';
import { DashboardEditListComponent } from './dashboard-edit-list.component';
import { DashboardAddItemComponent } from './dashboard-add-item.component';
import { DashboardEditItemComponent } from './dashboard-edit-item.component';
import { DashboardRouteGuard } from './dashboard.route.guard';

@NgModule({
  imports: [
    RouterModule.forChild([
      {
        path: 'dashboard',
        component: DashboardComponent,
        canActivateChild: ['DashboardRouteGuard'],
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
      provide: 'DashboardRouteGuard',
      useClass: DashboardRouteGuard
    }
  ]
})
export class DashboardRoutingModule { }
