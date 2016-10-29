import { Component, OnInit, OnDestroy }    from '@angular/core';
import { Router, ActivatedRoute, Params }   from '@angular/router';
import { ListModel }            from '../../models/list.model';
import { ListService }          from '../../services/list.service';
import {Observable}             from 'rxjs/Rx';
import {ToasterService}             from 'angular2-toaster/angular2-toaster';

@Component({
  templateUrl: './dashboard-edit-list.html'
})
export class DashboardEditListComponent implements OnDestroy, OnInit {
  submitted = false;
  list: ListModel;

  constructor (
    private listService: ListService,
    private router: Router,
    private route: ActivatedRoute,
    private toaster: ToasterService
  ) {
    this.list = new ListModel();
  }

  ngOnInit() {
    this.route.params.forEach((params: Params) => {
     let id = +params['id']; // (+) converts string 'id' to a number
     this.list.id = id;
     let list = ListService.getCachedList(id);
     if (list) {
       this.list = list.copy();
     } else {
       this.listService.getList(id)
       .catch(this.handleNoListError(this))
       .subscribe(
         (listResp) => {
           this.list = listResp.copy();
         }
       );
     }
    });
  }

  onSubmit() {
    this.submitted = true;
    this.listService.updateList(this.list).subscribe(
      (list) => {
        this.router.navigate(['/dashboard/lists', list.id]);
        this.toaster.pop('success', 'List updated.');
      }
    );
  }

  onListDeleted () {
    this.router.navigate(['/dashboard']);
  }

  ngOnDestroy () {
    if (!this.submitted) {
      for (let i = ListService.lists.length - 1; i >= 0; i--) {
        if (ListService.lists[i].id === this.list.id) {
          this.list = ListService.lists[i];
          break;
        }
      }
    }
  }

  private handleNoListError (self: DashboardEditListComponent) {
    return (err: any, cauth: any) => {
      return Observable.throw(`List with id ${self.list.id} was not found on the server.`);
    };
  }
}
