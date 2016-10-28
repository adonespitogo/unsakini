import {NgModule} from '@angular/core';
import {CommonModule} from '@angular/common';
import {HttpModule} from '@angular/http';
import {FormsModule} from '@angular/forms';
import {SettingsRoutingModule} from './settings.routing.module';
import { CollapseModule } from 'ng2-bootstrap/ng2-bootstrap';
import { ClipboardModule }  from 'angular2-clipboard';
import {DirectivesModule} from '../directives/directives.module';

import {SettingsComponent} from './settings.component';
import {SettingsMainComponent} from './main/settings.main.component';
import {AccountSettingsComponent} from './account/account.component';

@NgModule({
  imports: [
    HttpModule,
    FormsModule,
    CommonModule,
    SettingsRoutingModule,
    CollapseModule,
    DirectivesModule,
    ClipboardModule,
  ],
  declarations: [
    SettingsComponent,
    SettingsMainComponent,
    AccountSettingsComponent
  ],
  exports: [
    CommonModule,
    HttpModule,
    FormsModule,
    AccountSettingsComponent,
    SettingsRoutingModule
  ],
  providers: [
    // BreadcrumbService
  ]
})

export class SettingsModule {

}
