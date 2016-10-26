import { NgModule }      from '@angular/core';
import { RouterModule } from '@angular/router';
import { MarkedTextDirective } from './marked-text.directive';
import { LogoutDirective } from './logout.directive';
import { ToasterModule } from 'angular2-toaster/angular2-toaster';
import { CurrentUserDirective } from './current.user.directive';

@NgModule({
  imports: [
    RouterModule,
    ToasterModule,
  ],
  declarations: [
    MarkedTextDirective,
    LogoutDirective,
    CurrentUserDirective,
  ],
  exports: [
    MarkedTextDirective,
    LogoutDirective,
    ToasterModule,
    RouterModule,
    CurrentUserDirective
  ]
})

export class DirectivesModule { }
