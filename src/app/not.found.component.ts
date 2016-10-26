import {Component} from '@angular/core';

@Component({
  template: `
    <div class="container text-center">
      <h1>Page not found</h1>
      Go back to <a [routerLink]="['/dashboard']">Dashboard</a> now.
    </div>
  `
})

export class NotFoundComponent {}