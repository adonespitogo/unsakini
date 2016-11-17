import {NgModule} from '@angular/core';
import {RouterModule} from '@angular/router';

import {SettingsComponent} from './settings.component';
import {SecuritySettingsComponent} from './security/settings.security.component';
import {SettingsRouteGuard} from './settings.route.guard';
import {AccountSettingsComponent} from './account/settings.account.component';

@NgModule({
  imports: [
    RouterModule.forChild([
      {
        path: 'settings',
        component: SettingsComponent,
        canActivateChild: ['SettingsRouteGuard'],
        canActivate: ['SettingsRouteGuard'],
        children: [
          {
            path: 'security',
            component: SecuritySettingsComponent
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
