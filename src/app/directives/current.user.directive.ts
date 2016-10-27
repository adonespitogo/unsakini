import { Directive, ElementRef, Renderer, AfterViewInit, OnDestroy} from '@angular/core';
import { Subscription } from 'rxjs/Rx';
import { UserService } from '../services/user.service';
// import { UserModel } from '../models/user.model';

@Directive({
  selector: '[appCurrentUser]'
})

export class CurrentUserDirective implements AfterViewInit, OnDestroy {

  private subscription: Subscription;

  constructor (
    private el: ElementRef,
    private renderer: Renderer,
    private userService: UserService
  ) { }

  ngAfterViewInit () {
    this.subscription = this.userService.getCurrentUser(true).subscribe();
    this.userService.currentUser$.subscribe((user) => {
      this.renderer.setElementProperty(this.el.nativeElement, 'innerHTML', `${user.name}`);
    });
  }

  ngOnDestroy () {
    this.subscription.unsubscribe();
  }

}
