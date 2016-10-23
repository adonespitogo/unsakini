import { Directive, Input, OnChanges, ElementRef, Renderer} from '@angular/core';
import { CryptoService } from '../services/crypto.service';
declare var marked: any;

@Directive({
  selector: '[markedText]'
})

export class MarkedTextDirective {

  constructor (
    private el: ElementRef,
    private renderer: Renderer
  ) {}

  @Input() text: string;

  ngOnChanges () {
    if (this.text) {
      this.renderer.setElementProperty(this.el.nativeElement, 'innerHTML', marked(this.text));
    }
  }
}