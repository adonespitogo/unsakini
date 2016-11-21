/* tslint:disable:no-unused-variable */

import { inject, async, ComponentFixture, TestBed } from '@angular/core/testing';
import { Observable } from 'rxjs/Observable';
import 'rxjs/add/observable/of';
import 'rxjs/add/observable/throw';
import { By } from '@angular/platform-browser';
import { DebugElement } from '@angular/core';
import { Angular2TokenService } from 'angular2-token';

import { RegistrationComponent } from './registration.component';

let user = {
  name: 'first last',
  email: 'hello@world.com',
  password: null,
  password_confirmation: null
}

let status = 0
let errors = []

class Angular2TokenServiceMock {
  registerAccount(user) {

    if (status === 200) {
      return Observable.of({
        status: 200,
        json: () => {
          return {
            user
          }
        }
      });
    } else {
      return Observable.throw({
        status: status,
        json: () => {
          return {
            errors: errors
          }
        }
      });
    }
  }
}

describe('RegistrationComponent', () => {
  let component: RegistrationComponent;
  let fixture: ComponentFixture<RegistrationComponent>;
  let compiled: any;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      imports: [
      ],
      declarations: [RegistrationComponent],
      providers: [
        {
          provide: Angular2TokenService,
          useClass: Angular2TokenServiceMock
        }
      ]
    })
      .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(RegistrationComponent);
    component = fixture.componentInstance;
    compiled = fixture.debugElement.nativeElement;
    fixture.detectChanges();
  });

  describe('Component', () => {

    it('should create', () => {
      expect(component).toBeTruthy();
    });

    it('should have token service', () => {
      expect(component.service).toBeDefined();
    });

    it('should have user', () => {
      expect(component.user).toEqual({
        name: '',
        email: '',
        password: '',
        password_confirmation: ''
      });
    });

    it('should handle http 422', () => {
      status = 422
      errors = ['some errors']
      component.doSubmit(user)
      expect(component.success).toBe(false)
      expect(component.errors).toEqual(errors)
      expect(compiled.querySelector('.alert-success')).toBeFalsy()
    })

    it('should handle http 500 and other errors', () => {
      status = 500
      component.doSubmit(user)
      expect(component.success).toBe(false)
      expect(component.errors).toEqual(['Something went wrong.'])
      expect(compiled.querySelector('.alert-success')).toBeFalsy()
    })

    it('should notify when success', () => {
      status = 200
      component.doSubmit(user)
      expect(component.success).toBe(true)
      expect(compiled.querySelector('.alert-success')).toBeFalsy()
    })

  });

  describe('View', () => {

    it('should have form', () => {
      expect(compiled.querySelector('form')).toBeTruthy();
    });

    it('should have input name', () => {
      expect(compiled.querySelector('input[name="name"]')).toBeTruthy();
    });

    it('should have input email', () => {
      expect(compiled.querySelector('input[name="email"][type="email"]')).toBeTruthy();
    });

    it('should have input password', () => {
      expect(compiled.querySelector('input[name="password"][type="password"]')).toBeTruthy();
    });

    it('should have input password confirmation', () => {
      expect(compiled.querySelector('input[name="password_confirmation"][type="password"]')).toBeTruthy();
    });

    it('should have submit button', () => {
      expect(compiled.querySelector('button[type="submit"]')).toBeTruthy();
    });

  });

});
