import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { ListModel }    from '../models/list.model';
import { ListService }    from '../services/list.service';

@Component({
  selector: 'list-form',
  templateUrl: 'views/dashboard/views/dashboard-new-list.html'
})
export class DashboardNewListComponent {
  submitted = false;
  list: ListModel;

  constructor (
    private listSerive: ListService,
    private router: Router
  ) { }

  ngOnInit() {
    this.list = new ListModel();
  }

  onSubmit() {
    this.submitted = true;
    this.listSerive.createList(this.list).subscribe(
      (list) => {
        this.router.navigate(['/dashboard/lists', list.id]);
      }
    );
  }
}
