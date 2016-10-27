import {NgModule} from '@angular/core';
import {CommonModule} from '@angular/common';
import {HttpModule} from '@angular/http';
import {FormsModule} from '@angular/forms';
// import {Ng2BreadcrumbModule, BreadcrumbService} from 'ng2-breadcrumb/ng2-breadcrumb';
import {SettingsRoutingModule} from './settings.routing.module';
import { CollapseModule } from 'ng2-bootstrap/ng2-bootstrap';
import {DirectivesModule} from '../directives/directives.module';

import {SettingsComponent} from './settings.component';
import {SettingsMainComponent} from './main/settings.main.component';

@NgModule({
  imports: [
    HttpModule,
    FormsModule,
    SettingsRoutingModule,
    // Ng2BreadcrumbModule,
    CollapseModule,
    DirectivesModule,
  ],
  declarations: [
    SettingsComponent,
    SettingsMainComponent
  ],
  exports: [
    CommonModule,
    HttpModule,
    FormsModule,
    // Ng2BreadcrumbModule,
    SettingsRoutingModule
  ],
  providers: [
    // BreadcrumbService
  ]
})

export class SettingsModule {

}
