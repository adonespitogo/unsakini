/* tslint:disable:no-unused-variable */

import { TestBed, async, inject } from '@angular/core/testing';
import { Http, BaseRequestOptions, Response, ResponseOptions, Headers, RequestMethod } from '@angular/http';
import { MockBackend } from '@angular/http/testing';
import { HttpService, IAccount } from './http.service';

describe('HttpService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [
      	HttpService,
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

	it('', inject([HttpService], (service: HttpService) => {
	expect(service).toBeTruthy();
	}));

  describe('Registration', () => {

    it('jsonizes error', inject([HttpService, MockBackend], (service: HttpService, backend: MockBackend) => {
      
      let errors = ['name cant be blank']

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

      service.registerAccount(acct).subscribe(
        (res) => {},
        (res) => {
          expect(res).toEqual(errors)
        })

    }));

    it('handles success response', inject([HttpService, MockBackend], (service: HttpService, backend: MockBackend) => {
      
      let acct: IAccount = {
        name: '',
        email: '',
        password: '',
        password_confirmation: ''
      }


      let mockResponse = new Response(new ResponseOptions({
        status: 422,
        body: acct
      }))

      backend.connections.subscribe(c => c.mockRespond(mockResponse));
      service.registerAccount(acct).subscribe(
        (res) => {
          expect(res).toBe(acct)
        })

    }));

  });

});
