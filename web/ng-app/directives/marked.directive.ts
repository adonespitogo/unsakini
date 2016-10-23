import {Component} from '@angular/core';

@Component({
  moduleId: 'asdf',
  selector: 'marked',
  template: `<div>{{text}}</div>`
})

export class MarkedDirective {
  public text: string;

  constructor () {
    this.text = 'Hello world text!!!';
  }
}