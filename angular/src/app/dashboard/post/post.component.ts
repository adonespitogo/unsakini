import { Component, OnInit } from '@angular/core';

@Component({
  templateUrl: './post.component.html',
  styleUrls: ['./post.component.css']
})
export class PostComponent implements OnInit {

  post = {
    title: 'Post title',
    content: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Dignissimos error magni eligendi magnam. Minus consectetur quidem, sapiente officiis, vel eos veniam blanditiis. Quam, ut non nesciunt aspernatur, cupiditate mollitia facilis.',
    options: {
      open: false
    },
    comments: [
      {
        user: 'Adones Pitogo',
        content: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Rerum sit, expedita cum perspiciatis numquam nisi quis reiciendis culpa optio ratione sapiente saepe quod tempora quisquam commodi dolores ipsum, consectetur velit.',
        options: {
          open: false
        }
      }
    ]
  }

  public constructor() { }

  ngOnInit() {

  }

}
