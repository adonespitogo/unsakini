import { Directive, Input, ElementRef, Renderer, HostListener} from '@angular/core';
import { Router } from '@angular/router';
import {ToasterService} from 'angular2-toaster/angular2-toaster';
import {AuthService} from '../services/auth.service';
import { Angular2TokenService } from 'angular2-token';

@Directive({
  selector: '[appLogout]'
})

export class LogoutDirective {

  @Input() text: string;

  @HostListener('click') onClick () {
    this.doLogout();
  }

  constructor (
    private el: ElementRef,
    private renderer: Renderer,
    private router: Router,
    private toaster: ToasterService,
    private tokenService: Angular2TokenService
  ) {}

  doLogout () {
    if (confirm('Are you sure you want to logout?')) {
      this.tokenService.signOut().subscribe((success) => {
        this.router.navigate(['/login']);
        this.toaster.pop('warning', 'You are now logged out.');
      }, (err) => {
        console.log(err);
      })
    }
  }
}
