import { Component, OnInit, OnDestroy }    from '@angular/core';
import { Router, ActivatedRoute, Params }   from '@angular/router';
import { ListModel }            from '../models/list.model';
import { ListService }          from '../services/list.service';
import {Observable}             from 'rxjs/Rx';

@Component({
  selector: 'list-form',
  templateUrl: 'views/dashboard/views/dashboard-edit-list.html'
})
export class DashboardEditListComponent implements OnDestroy, OnInit {
  submitted = false;
  list: ListModel;
  origList: ListModel;

  constructor (
    private listService: ListService,
    private router: Router,
    private route: ActivatedRoute
  ) { }

  ngOnInit() {
    this.route.params.forEach((params: Params) => {
     let id = +params['id']; // (+) converts string 'id' to a number
     this.list = new ListModel({id: id, name: '', items: []});
     this.listService.getList(id)
     .catch(this.handleNoListError(this))
     .subscribe(
       (list) => {
         this.list = list;
         this.origList = list.copy();
       }
     );
    });
  }

  onSubmit() {
    this.submitted = true;
    this.listService.updateList(this.list).subscribe(
      (list) => {
        this.router.navigate(['/dashboard/lists', list.id]);
      }
    );
  }

  ngOnDestroy () {
    if (!this.submitted) {
      this.list.name = this.origList.name;
    }
  }

  private handleNoListError (self: DashboardEditListComponent) {
    return (err: any, cauth: any) => {
      return Observable.throw(`List with id ${self.list.id} was not found on the server.`);
    };
  }
}
