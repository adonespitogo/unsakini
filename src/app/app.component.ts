import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { ToasterConfig } from 'angular2-toaster/angular2-toaster';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  title = 'UNSAKINI';

  public toasterconfig: ToasterConfig = new ToasterConfig({
    positionClass: 'toast-bottom-right',
    timeout: 15000
  });

  constructor(
    private router: Router
  ) {}
}
