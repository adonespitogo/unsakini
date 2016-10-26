import {Component, OnInit} from "@angular/core";
import { Router } from '@angular/router';
import {ListService} from "../services/list.service";
import {ListModel} from "../models/list.model";
import {ToasterService} from "angular2-toaster/angular2-toaster";

@Component({
  templateUrl: './views/dashboard.html',
  // providers: [
  //   ListService
  // ],
  styleUrls: ['./styles/dashboard.css']
})

export class DashboardComponent {

  constructor (
    private listService: ListService,
    private router: Router,
    private toaster: ToasterService
  ) {}

  public isCollapsed:boolean = true;

  ngOnInit () {
    this.listService.getLists().subscribe();
  }

  getLists () {
    return ListService.lists;
  }

}
