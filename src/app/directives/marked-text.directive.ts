import { Directive, Input, OnChanges, ElementRef, Renderer} from '@angular/core';
import * as marked from 'marked';

@Directive({
  selector: '[appMarkedText]'
})

export class MarkedTextDirective implements OnChanges {

  @Input() text: string;

  constructor (
    private el: ElementRef,
    private renderer: Renderer
  ) {}

  ngOnChanges () {
    if (this.text) {
      this.renderer.setElementProperty(this.el.nativeElement, 'innerHTML', marked(this.text));
    }
  }
}
