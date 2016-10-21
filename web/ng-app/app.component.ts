import { Component } from '@angular/core';
import { CoursesComponent } from './courses.component';

@Component({
  selector: 'my-app',
  templateUrl: '/views/app.component.html',
  entryComponents: [
    CoursesComponent
  ]
})

export class AppComponent { }
