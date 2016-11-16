import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { ListModel }    from '../../models/list.model';
import { ListService }  from '../../services/list.service';
import {ToasterService} from 'angular2-toaster/angular2-toaster';

@Component({
  templateUrl: './dashboard-new-list.html'
})
export class DashboardNewListComponent implements OnInit {
  submitted = false;
  list: ListModel;

  constructor (
    private listSerive: ListService,
    private router: Router,
    private route: ActivatedRoute,
    private toaster: ToasterService
  ) { }

  ngOnInit() {
    this.list = new ListModel();
  }

  onSubmit() {
    this.submitted = true;
    let l = new ListModel(this.list.serialize());
    this.listSerive.createList(l).subscribe(
      (list) => {
        this.toaster.pop('success', 'List Created');
        this.router.navigate(['/dashboard/lists', list.id]);
      }
    );
  }
}
