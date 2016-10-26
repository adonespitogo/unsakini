import {Component, OnInit} from "@angular/core";
import { Router, ActivatedRoute, Params } from '@angular/router';
import {ListService} from '../services/list.service';
import {ItemService} from '../services/item.service';
import {ListModel} from '../models/list.model';
import {Observable} from 'rxjs/Rx';

@Component({
  templateUrl: './views/dashboard-list-items.html',
  // styleUrls: ['../css/dashboard/styles/dashboard-list-items.css']
})

export class DashboardListItemsComponent implements OnInit {

  public list: ListModel;

  constructor (
    private itemService: ItemService,
    private listService: ListService,
    private route: ActivatedRoute,
    private router: Router
  ) {
    this.list = new ListModel();
  }

  getList () {
    var list = this.listService.getCachedList(this.list.id);
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
          this.redirectTo();
        }
      );
    }
  }

  doDeleteItem (item) {
    if (window.confirm(`Are you sure you want to delete item "${item.title}"?`)) {
      this.itemService.deleteItem(item).subscribe();
    }
  }

  private redirectTo () {
    let lists = ListService.lists;
    if (lists) {
      if (lists.length > 0) {
        this.router.navigate(['/dashboard/lists', lists[0].id]);
      } else {
        this.router.navigate(['/dashboard']);
      }
    } else {
      this.listService.getLists().subscribe(
        (lists) => {
          if (lists.length > 0) {
            this.router.navigate(['/dashboard/lists', lists[0].id]);
          } else {
            this.router.navigate(['/dashboard']);
          }
        }
      );
    }
  }

  private handleNoListError (self: DashboardListItemsComponent) {
    return (err: any, cauth: any) => {
      self.redirectTo();
      return Observable.throw(`List with id ${self.list.id} was not found on the server.`);
    };
  }
}
