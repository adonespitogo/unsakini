import { Directive, ElementRef, Renderer, AfterViewInit, OnDestroy} from '@angular/core';
import { Subscription } from 'rxjs/Rx';
import { UserService } from '../services/user.service';
import { UserModel } from '../models/user.model';

@Directive({
  selector: '[appCurrentUser]'
})

export class CurrentUserDirective implements AfterViewInit, OnDestroy {

  private subscription: Subscription;
  private user: UserModel;

  constructor (
    private el: ElementRef,
    private renderer: Renderer,
    private userService: UserService
  ) {
    this.subscription = userService.currentUser$.subscribe((user: UserModel) => {
      this.user = user;
      this.setContent();
    });
  }

  ngAfterViewInit () {
    this.userService.getCurrentUser(true).subscribe();
    this.userService.currentUser$.subscribe((user) => {
      this.user = user;
      this.setContent();
    });
  }

  ngOnDestroy () {
    this.subscription.unsubscribe();
  }

  private setContent () {
    this.renderer.setElementProperty(this.el.nativeElement, 'innerHTML', `${this.user.name}`);
  }

}
