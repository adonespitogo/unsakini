import {Component, OnInit} from '@angular/core';
import { Router } from '@angular/router';
import {ListService} from '../services/list.service';
import {ToasterService} from 'angular2-toaster/angular2-toaster';

@Component({
  templateUrl: './views/dashboard.html',
  styleUrls: ['./styles/dashboard.scss']
})

export class DashboardComponent implements OnInit {

  public isCollapsed: boolean = true;
  public sidebarOpen: boolean = false;

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
