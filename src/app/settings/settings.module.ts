import {NgModule} from "@angular/core";
import {CommonModule} from "@angular/common";
import {HttpModule} from "@angular/http";
import {FormsModule} from "@angular/forms";
import {Ng2BreadcrumbModule, BreadcrumbService} from 'ng2-breadcrumb/ng2-breadcrumb';
import {SettingsRoutingModule} from "./settings.routing.module";
import {DirectivesModule} from "../directives/directives.module";

import {SettingsComponent} from "./settings.component";
import {SettingsMainComponent} from "./main/settings.main.component";

@NgModule({
  imports: [
    HttpModule,
    FormsModule,
    SettingsRoutingModule,
    Ng2BreadcrumbModule,
    DirectivesModule,
  ],
  declarations: [
    SettingsComponent,
    SettingsMainComponent
  ],
  exports:[
    CommonModule,
    HttpModule,
    FormsModule,
    Ng2BreadcrumbModule,
    SettingsRoutingModule
  ],
  providers: [
    BreadcrumbService
  ]
})

export class SettingsModule {

}