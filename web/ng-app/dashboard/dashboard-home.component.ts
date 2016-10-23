import {Component} from "@angular/core";

@Component({
  templateUrl: '/views/dashboard/views/dashboard-home.html',
  styleUrls: ['css/dashboard/styles/dashboard-home.css']
})

export class DashboardHomeComponent {
  constructor () {
    console.log('test dashboard');
  }
}