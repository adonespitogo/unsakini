

import {Component} from "@angular/core";
import { Router } from '@angular/router';
import {ListService} from "../services/list.service";
import {ListModel} from "../models/list.model";

@Component({
  templateUrl: '/views/dashboard/views/dashboard.html',
  providers: [
    ListService
  ],
  styleUrls: ['css/dashboard/styles/dashboard.css']
})

export class DashboardComponent {

  lists: Array<ListModel>;

  constructor (
    private listService: ListService,
    private router: Router
  ) {}

  ngOnInit () {
    this.lists = [];
    this.listService.getLists().subscribe(
      (data) => {
        this.lists = data;
      }
    );
  }

}