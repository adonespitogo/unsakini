
import { inject, async, ComponentFixture, TestBed } from '@angular/core/testing';
import { MockBackend, MockConnection } from '@angular/http/testing';
import { Http, BaseRequestOptions, Response, ResponseOptions } from '@angular/http';

import { HttpService } from '..';
import { RegistrationService, IAccount } from '.'

describe('RegistrationService', () => {

  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [
        HttpService,
        RegistrationService,
        BaseRequestOptions,
        MockBackend,
        {
          provide: Http,
          useFactory: (backend, defaultOptions) => { return new Http(backend, defaultOptions) },
          deps: [MockBackend, BaseRequestOptions]
        },
      ]
    });
  });

  it(`handles error`, inject([MockBackend, RegistrationService], (backend: MockBackend, service: RegistrationService) => {
    let errors = ['name is required']
    let mockResponse = new Response(new ResponseOptions({
      status: 422,
      body: errors
    }))

    backend.connections.subscribe(c => c.mockError(mockResponse));

    let acct: IAccount = {
      name: '',
      email: '',
      password: '',
      password_confirmation: ''
    }

    service.registerAccount(acct).subscribe((res: Response) => {}, (err: Response) => {
      expect(err).toEqual(errors)
    });

  }))

  it(`handles success`, inject([MockBackend, RegistrationService], (backend: MockBackend, service: RegistrationService) => {

    let acct: IAccount = {
      name: '',
      email: '',
      password: '',
      password_confirmation: ''
    }

    let mockResponse = new Response(new ResponseOptions({
      status: 200,
      body: acct
    }))

    backend.connections.subscribe(c => c.mockRespond(mockResponse));

    service.registerAccount(acct).subscribe((res: Response) => {
      expect(res).toEqual(acct)
    });

  }))

});
