import {Component} from "@angular/core";
import { Router, ActivatedRoute, Params } from '@angular/router';
import {ListService} from '../services/list.service';
import {ListModel} from '../models/list.model';
import {Observable} from 'rxjs/Rx';

@Component({
  templateUrl: '/views/dashboard/views/dashboard-list-items.html',
  // styleUrls: ['../css/dashboard/styles/dashboard-list-items.css']
})

export class DashboardListItemsComponent {

  public list: ListModel;

  constructor (
    private listService: ListService,
    private route: ActivatedRoute,
    private router: Router
  ) {
  }

  ngOnInit() {
    this.list = new ListModel();
    this.route.params.forEach((params: Params) => {
    let id = +params['id']; // (+) converts string 'id' to a number
    this.listService.getList(id)
    .catch(this.handleNoListError(this))
    .subscribe(
     (list) => {
       this.list = list;
     }
    );
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

  private redirectTo () {
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

  private handleNoListError (self: DashboardListItemsComponent) {
    return (err: any, cauth: any) => {
      self.redirectTo();
      return Observable.throw(`List with id ${self.list.id} was not found on the server.`);
    };
  }
}