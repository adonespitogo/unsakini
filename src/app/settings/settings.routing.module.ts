import {NgModule} from '@angular/core';
import {RouterModule} from '@angular/router';

import {SettingsComponent} from './settings.component';
import {SettingsMainComponent} from './main/settings.main.component';
import {SettingsRouteGuard} from './settings.route.guard';
import {AccountSettingsComponent} from './account/account.component';

@NgModule({
  imports: [
    RouterModule.forChild([
      {
        path: 'settings',
        component: SettingsComponent,
        canActivateChild: ['DashboardRouteGuard'],
        canActivate: ['SettingsRouteGuard'],
        children: [
          {
            path: 'security',
            component: SettingsMainComponent
          },
          {
            path: 'account',
            component: AccountSettingsComponent
          }
        ]
      }
    ])
  ],
  providers: [
    {
      provide: 'SettingsRouteGuard',
      useClass: SettingsRouteGuard
    }
  ],
  exports: [
    RouterModule
  ]
})

export class SettingsRoutingModule {

}
