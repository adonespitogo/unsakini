
import { NgModule }     from '@angular/core';
import { RouterModule } from '@angular/router';
import {DashboardComponent} from "./components/dashboard.component";


@NgModule({
  imports: [
    RouterModule.forRoot([
      {path: '', redirectTo: 'dashboard', pathMatch: 'full'},
      {path: 'dashboard', component: DashboardComponent},
    ], {useHash: true})
  ],
  exports: [
    RouterModule
  ]
})
export class AppRoutingModule {}
