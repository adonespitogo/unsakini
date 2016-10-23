import {Component} from "@angular/core";
import {ListService} from '../services/list.service';
import {ListModel} from '../models/list.model';

@Component({
  templateUrl: '/views/dashboard/views/dashboard-new-list.html',
  // styleUrls: ['../css/dashboard/styles/dashboard-list-items.css']
})

export class DashboardNewListComponent {

  public list: ListModel;

  constructor (
    private listService: ListService
  ) {
    this.list = new ListModel();
  }
}