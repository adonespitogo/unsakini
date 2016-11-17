import { Directive, Input, Output,   ElementRef, Renderer, HostListener, EventEmitter} from '@angular/core';
import { Router } from '@angular/router';
import {ToasterService} from 'angular2-toaster/angular2-toaster';
import {ItemModel} from '../models/item.model';
import {ItemService} from '../services/item.service';

@Directive({
  selector: '[appDeleteItem]'
})

export class DeleteItemDirective {

  @Input() item: ItemModel;

  @Output() onItemDeleted = new EventEmitter<boolean>();

  @HostListener('click') onClick () {
    this.doDelete();
  }

  constructor (
    private el: ElementRef,
    private renderer: Renderer,
    private router: Router,
    private toaster: ToasterService,
    private itemService: ItemService,
  ) {}

  doDelete () {
    if (confirm(`Are you sure you want to delete ${this.item.title}?`)) {
      this.itemService.deleteItem(this.item).subscribe(() => {
        this.toaster.pop('success', `Item ${this.item.title} has been deleted.`);
        this.onItemDeleted.emit(true);
      });
    }
  }
}
