import { Directive, ElementRef, Renderer, AfterViewInit} from '@angular/core';
// import { SubjectBehavior } from 'rxjs/Rx';
import { UserService } from '../services/user.service';
// import { UserModel } from '../models/user.model';

@Directive({
  selector: '[appCurrentUser]'
})

export class CurrentUserDirective implements AfterViewInit {

  constructor (
    private el: ElementRef,
    private renderer: Renderer,
    private userService: UserService
  ) { }

  ngAfterViewInit () {
    this.userService.getCurrentUser(true).subscribe();
    this.userService.currentUser$.subscribe((user) => {
      this.renderer.setElementProperty(this.el.nativeElement, 'innerHTML', `${user.name}`);
    });
  }

}
