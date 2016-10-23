import {Component} from "@angular/core";
import { Router, ActivatedRoute, Params } from '@angular/router';
import {ItemService} from '../services/item.service';
import {ItemModel} from '../models/item.model';

@Component({
  templateUrl: '/views/dashboard/views/dashboard-item.html',
  providers: [
    ItemService
  ]
  // styleUrls: ['../css/dashboard/styles/dashboard-list-items.css']
})

export class DashboardItemComponent {

  public item: ItemModel;

  constructor (
    private route: ActivatedRoute,
    private router: Router,
    private itemService: ItemService
  ) {
    this.item = new ItemModel();
  }

  ngOnInit() {
    this.route.params.forEach((params: Params) => {
     let id = +params['id']; // (+) converts string 'id' to a number
     this.itemService.getItem(id).subscribe(
       (item) => {
         this.item = item;
       }
     );
    });
  }
}