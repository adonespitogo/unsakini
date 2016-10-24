

import {Component, OnInit, OnChanges, SimpleChange} from "@angular/core";
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

export class DashboardComponent implements OnInit, OnChanges {

  constructor (
    private listService: ListService,
    private router: Router
  ) {}

  ngOnInit () {
    this.listService.getLists().subscribe();
  }

  getLists () {
    return ListService.lists;
  }

  ngOnChanges (changes: {[propertyName: string]: SimpleChange}) {
    console.log(changes);
  }

}