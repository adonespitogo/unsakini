import { Directive, Input, Output,   ElementRef, Renderer, HostListener, EventEmitter} from '@angular/core';
import { Router } from '@angular/router';
import {ToasterService} from 'angular2-toaster/angular2-toaster';
import {ListModel} from '../models/list.model';
import {ListService} from '../services/list.service';

@Directive({
  selector: '[appDeleteList]'
})

export class DeleteListDirective {

  @Input() list: ListModel;

  @HostListener('click') onClick () {
    this.doDelete();
  }

  @Output() onDelete = new EventEmitter<boolean>();

  constructor (
    private el: ElementRef,
    private renderer: Renderer,
    private router: Router,
    private toaster: ToasterService,
    private listService: ListService,
  ) {}

  doDelete () {
    if (confirm(`Are you sure you want to delete ${this.list.name} ?`)) {
      this.listService.deleteList(this.list).subscribe(() => {
        this.toaster.pop('success', `List ${this.list.name} has been deleted.`);
        this.onDelete.emit(true);
      })
    }
  }
}
