import { Component, OnInit, OnDestroy }    from '@angular/core';
import { Router, ActivatedRoute, Params }   from '@angular/router';
import { ListModel }            from '../models/list.model';
import { ListService }          from '../services/list.service';
import { ItemService }          from '../services/item.service';
import { ItemModel }          from '../models/item.model';
import {Observable}             from 'rxjs/Rx';
import {ToasterService}             from 'angular2-toaster/angular2-toaster';

@Component({
  // selector: 'list-form',
  templateUrl: './views/dashboard-edit-item.html'
})
export class DashboardEditItemComponent implements OnDestroy, OnInit {

  submitted = false;
  list: ListModel;
  item: ItemModel;

  constructor (
    private itemService: ItemService,
    private listService: ListService,
    private router: Router,
    private route: ActivatedRoute,
    private toaster: ToasterService
  ) {
    this.item = new ItemModel();
    this.list = new ListModel();
  }

  ngOnInit() {
    this.route.params.forEach((params: Params) => {
     let id = +params['id']; // (+) converts string 'id' to a number
     let chachedItem = ItemService.getCachedItem(id);
     if (chachedItem) {
       this.item = chachedItem.copy();
     } else {
       this.itemService.getItem(id)
       .catch(this.handleNoListError(this))
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
    this.item.list = this.list;
    this.itemService.updateItem(this.item).subscribe(
      (item) => {
        this.router.navigate(['/dashboard/items', item.id]);
        this.toaster.pop('success', 'Item updated.');
      }
    );
  }

  ngOnDestroy () {
    if (!this.submitted) {
      this.list = ListService.getCachedList(this.list.id);
    }
  }

  private handleNoListError (self: DashboardEditItemComponent) {
    return (err: any, cauth: any) => {
      return Observable.throw(`List with id ${self.list.id} was not found on the server.`);
    };
  }
}
