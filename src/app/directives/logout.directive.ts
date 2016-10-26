import { Directive, Input, OnChanges, ElementRef, Renderer, HostListener} from '@angular/core';
import { Router } from "@angular/router";
import { CryptoService } from '../services/crypto.service';
import {ToasterService} from 'angular2-toaster/angular2-toaster';
import * as marked from "marked";

@Directive({
  selector: '[logout]'
})

export class LogoutDirective {

  constructor (
    private el: ElementRef,
    private renderer: Renderer,
    private router: Router,
    private toaster: ToasterService
  ) {}

  @Input() text: string;

  @HostListener('click') onClick () {
    this.doLogout();
  }

  doLogout () {
    if (confirm('Are you sure you want to logout?')) {
      localStorage.removeItem('auth_token');
      this.router.navigate(['/login']);
      this.toaster.pop('warning', "You are now logged out.")
    }
  }
}