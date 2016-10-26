import { Component } from '@angular/core';
import { Router } from '@angular/router';
// import {ToasterService} from "angular2-toaster/angular2-toaster";

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  title = 'UNSAKINI';

  IsConstructor(
    private router: Router
  ) {
    this.router.navigate('/dashboard');
  }
}
