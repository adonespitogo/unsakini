import {Component, OnInit} from "@angular/core";
import {ListService} from '../services/list.service';

@Component({
  templateUrl: './views/dashboard-home.html',
  // styleUrls: ['css/dashboard/styles/dashboard-home.css']
})

export class DashboardHomeComponent implements OnInit {

  constructor (
    listService: ListService
  ) {}

  ngOnInit () {

  }

  getLists () {
    return ListService.lists;
  }
}
