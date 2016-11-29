import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-home',
  templateUrl: './board.component.html',
  styleUrls: ['./board.component.css']
})
export class BoardComponent implements OnInit {

  list = []

  public constructor() { }

  ngOnInit() {
    for (let i = 0; i < 10; i ++ ) {
      this.list.push({options: {
        open: false
      }});
    }
  }

}
