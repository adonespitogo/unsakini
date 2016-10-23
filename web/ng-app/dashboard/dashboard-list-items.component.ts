import {Component} from "@angular/core";
import { ActivatedRoute, Params } from '@angular/router';
import {ListService} from '../services/list.service';
import {ListModel} from '../models/list.model';

@Component({
  templateUrl: '/views/dashboard/views/dashboard-list-items.html',
  // styleUrls: ['../css/dashboard/styles/dashboard-list-items.css']
})

export class DashboardListItemsComponent {

  public list: ListModel;

  constructor (
    private listService: ListService,
    private route: ActivatedRoute
  ) {
    this.list = new ListModel({id: 0, name:'', items: []});
  }

  ngOnInit() {
    this.route.params.forEach((params: Params) => {
     let id = +params['id']; // (+) converts string 'id' to a number
     this.listService.getList(id).subscribe(
       (list) => {
         this.list = list;
       }
     );
    });
  }
}