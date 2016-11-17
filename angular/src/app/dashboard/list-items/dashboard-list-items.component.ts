import {Component, OnInit} from '@angular/core';
import { Router, ActivatedRoute, Params } from '@angular/router';
import {ListService} from '../../services/list.service';
import {ItemService} from '../../services/item.service';
import {ListModel} from '../../models/list.model';
import {Observable} from 'rxjs/Rx';
import {ToasterService} from 'angular2-toaster/angular2-toaster';

@Component({
  templateUrl: './dashboard-list-items.html',
})

export class DashboardListItemsComponent implements OnInit {

  public list: ListModel;

  constructor (
    private itemService: ItemService,
    private listService: ListService,
    private route: ActivatedRoute,
    private router: Router,
    private toaster: ToasterService
  ) {
    this.list = new ListModel();
  }

  getList () {
    let list = this.listService.getCachedList(this.list.id);
    if (list) {
      return list;
    } else {
      return this.list;
    }
  }

  ngOnInit() {
    this.route.params.forEach((params: Params) => {
      let id = +params['id']; // (+) converts string 'id' to a number
      let cachedList = this.listService.getCachedList(id);
      if (cachedList) {
        this.list = cachedList;
      } else {
        this.listService.getList(id)
        .catch(this.handleNoListError(this))
        .subscribe(
         (list) => {
           this.list = list;
         }
        );
      }

    });
  }

  doDeleteList (list) {
    if (window.confirm('Are you sure?')) {
      this.listService.deleteList(list).subscribe(
        () => {
          this.router.navigate(['/dashboard']);
          this.toaster.pop('success', 'List deleted');
        }
      );
    }
  }

  private handleNoListError (self: DashboardListItemsComponent) {
    return (err: any, cauth: any) => {
      self.router.navigate(['/dashboard']);
      self.toaster.pop('warning', 'No such list');
      return Observable.throw(`List with id ${self.list.id} was not found on the server.`);
    };
  }
}
