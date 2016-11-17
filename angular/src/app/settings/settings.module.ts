import {NgModule} from '@angular/core';
import {CommonModule} from '@angular/common';
import {HttpModule} from '@angular/http';
import {FormsModule} from '@angular/forms';
import {SettingsRoutingModule} from './settings.routing.module';
import { CollapseModule } from 'ng2-bootstrap/ng2-bootstrap';
import { ClipboardModule }  from 'angular2-clipboard';
import {DirectivesModule} from '../directives/directives.module';

import {SettingsComponent} from './settings.component';
import {SecuritySettingsComponent} from './security/settings.security.component';
import {AccountSettingsComponent} from './account/settings.account.component';

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
    SecuritySettingsComponent,
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
