import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';
import { DropdownModule } from 'ng2-bootstrap/ng2-bootstrap';
import { ModalModule } from 'ng2-bootstrap/ng2-bootstrap';

import { DashboardRoutesModule } from './dashboard.routes.module';
import { DashboardComponent } from './dashboard.component';
import { HomeComponent } from './home/home.component';
import { BoardComponent } from './board/board.component';
import { PostComponent } from './post/post.component';

@NgModule({
  imports: [
    CommonModule,
    RouterModule,
    DropdownModule,
    ModalModule,
    DashboardRoutesModule,
  ],
  declarations: [
    DashboardComponent,
    HomeComponent,
    BoardComponent,
    PostComponent,
  ]
})
export class DashboardModule { }
