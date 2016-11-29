import { Component, OnInit } from '@angular/core';

@Component({
  templateUrl: './post.component.html',
  styleUrls: ['./post.component.css']
})
export class PostComponent implements OnInit {

  list = []

  public constructor() { }

  ngOnInit() {
    for (let i = 0; i < 10; i ++ ) {
      this.list.push(i);
    }
  }

}
