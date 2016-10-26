import {Component, OnInit} from '@angular/core';
import { Router } from '@angular/router';
import {ListService} from '../services/list.service';
import {ToasterService} from 'angular2-toaster/angular2-toaster';

@Component({
  templateUrl: './views/dashboard.html',
  // providers: [
  //   ListService
  // ],
  styleUrls: ['./styles/dashboard.css']
})

export class DashboardComponent implements OnInit {

  public isCollapsed: boolean = true;

  constructor (
    private listService: ListService,
    private router: Router,
    private toaster: ToasterService
  ) {}

  ngOnInit () {
    this.listService.getLists().subscribe();
  }

  getLists () {
    return ListService.lists;
  }

}
