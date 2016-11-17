import {Component, OnInit} from '@angular/core';
import { Router, ActivatedRoute, Params } from '@angular/router';
import {ItemService} from '../../services/item.service';
import {ItemModel} from '../../models/item.model';
import {ListModel} from '../../models/list.model';

@Component({
  templateUrl: './dashboard-item.html'
})

export class DashboardItemComponent implements OnInit {

  public item: ItemModel;

  constructor (
    private route: ActivatedRoute,
    private router: Router,
    private itemService: ItemService
  ) {
    this.item = new ItemModel();
    this.item.list = new ListModel();
  }

  onItemDeleted (deleted: boolean) {
    if (deleted) {
      this.router.navigate(['/dashboard/lists', this.item.list_id]);
    }
  }

  ngOnInit() {
    this.route.params.forEach((params: Params) => {
     let id = +params['id']; // (+) converts string 'id' to a number
     let cItem = ItemService.getCachedItem(id);
     if (cItem) {
       this.item = cItem.copy();
     } else {
       this.itemService.getItem(id).subscribe(
         (item) => {
           this.item = item;
         }
       );
     }
    });
  }
}
