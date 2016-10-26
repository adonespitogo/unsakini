import {NgModule} from "@angular/core";
import {RouterModule} from "@angular/router";

import {SettingsComponent} from "./settings.component";
import {SettingsMainComponent} from "./main/settings.main.component";

@NgModule({
  imports: [
    RouterModule.forChild([
      {
        path: 'settings',
        component: SettingsComponent,
        children: [
          {
            path: '',
            component: SettingsMainComponent
          }
        ]
      }
    ])
  ],
  exports: [
    RouterModule
  ]
})

export class SettingsRoutingModule {

}