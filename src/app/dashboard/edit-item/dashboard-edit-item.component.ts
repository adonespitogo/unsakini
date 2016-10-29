import { Component, OnInit }    from '@angular/core';
import { Router, ActivatedRoute, Params }   from '@angular/router';
import { ListService }          from '../../services/list.service';
import { ItemService }          from '../../services/item.service';
import { ItemModel }          from '../../models/item.model';
import { ListModel }          from '../../models/list.model';
import {Observable}             from 'rxjs/Rx';
import {ToasterService}             from 'angular2-toaster/angular2-toaster';

@Component({
  // selector: 'list-form',
  templateUrl: './dashboard-edit-item.html',
  styleUrls: ['./dashboard-edit-item.scss']
})
export class DashboardEditItemComponent implements OnInit {

  submitted = false;
  item: ItemModel;

  constructor (
    private itemService: ItemService,
    private listService: ListService,
    private router: Router,
    private route: ActivatedRoute,
    private toaster: ToasterService
  ) {
    this.item = new ItemModel();
    this.item.list = new ListModel();
  }

  ngOnInit() {
    this.route.params.forEach((params: Params) => {
     let id = +params['id']; // (+) converts string 'id' to a number
     let chachedItem = ItemService.getCachedItem(id);
     if (chachedItem) {
       this.item = chachedItem.copy();
     } else {
       this.itemService.getItem(id)
       .catch(this.noItemError(this))
       .subscribe(
         (item) => {
           this.item = item;
         }
       );
     }
    });
  }

  onSubmit() {
    this.submitted = true;
    this.itemService.updateItem(this.item).subscribe(
      (item) => {
        this.router.navigate(['/dashboard/items', item.id]);
        this.toaster.pop('success', 'Item updated.');
      }
    );
  }

  itemDeleted() {
    this.router.navigate(['/dashboard/lists', this.item.list_id]);
  }

  private noItemError (self: DashboardEditItemComponent) {
    return (err: any, cauth: any) => {
      return Observable.throw(`Item with id ${self.item.id} was not found on the server.`);
    };
  }
}
