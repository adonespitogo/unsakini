import {Component} from "@angular/core";
import {ListModel} from "../models/list.model";
import {ListService} from "../services/list.service";

@Component({
  templateUrl: '/views/dashboard.component.html',
  providers: [
    ListService
  ]
})

export class DashboardComponent {

  lists: ListModel[];

  constructor (private listService: ListService) { }

  ngOnInit () {
    this.listService.getLists().subscribe(
      (data) => {
        console.log(data);
      }
    );
  }
}