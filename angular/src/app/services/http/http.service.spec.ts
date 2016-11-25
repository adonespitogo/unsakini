/* tslint:disable:no-unused-variable */

import { TestBed, async, inject } from '@angular/core/testing';
import { Http, BaseRequestOptions, Response, ResponseOptions, Headers, RequestMethod } from '@angular/http';
import { MockBackend } from '@angular/http/testing';
import { HttpService, IAccount } from './http.service';
import { environment } from '../../../environments/environment';

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

	it('should be defined', inject([HttpService], (service: HttpService) => {
    expect(service).toBeTruthy();
	}));

  describe('Append base api url /', () => {

    let expectMethod = (method: string) => {
  
      it(`appends base api url to the ${method} request`, inject([HttpService, MockBackend], (service: HttpService, backend: MockBackend) => {
        
        service.base_url = '/'
        let request_url = '/hello/world'

        backend.connections.subscribe((c) => {
          expect(c.request.url).toEqual((request_url))
          c.mockRespond(new Response(new ResponseOptions({ body: 'fake response' })))
        })

        if (method === 'post' || method === 'put' || method === 'patch')
          service[method](request_url, {}).subscribe()
        else
          service[method](request_url).subscribe()
      }));

    }

    let methods = ['post', 'get', 'put', 'patch', 'delete']

    for (let i = methods.length - 1; i >= 0; i--) {
      expectMethod(methods[i])
    }

  })

  describe('Base url is http://domain.com', () => {

    let expectMethod = (method: string) => {
  
      it(`appends base api url to the ${method} request`, inject([HttpService, MockBackend], (service: HttpService, backend: MockBackend) => {
        let domain = 'http://domain.com'
        service.base_url = domain
        let request_url = '/hello/world'

        backend.connections.subscribe((c) => {
          expect(c.request.url).toEqual(`${domain}${request_url}`)
          c.mockRespond(new Response(new ResponseOptions({ body: 'fake response' })))
        })

        if (method === 'post' || method === 'put' || method === 'patch')
          service[method](request_url, {}).subscribe()
        else
          service[method](request_url).subscribe()

      }));

    }

    let methods = ['post', 'get', 'put', 'patch', 'delete']

    for (let i = methods.length - 1; i >= 0; i--) {
      expectMethod(methods[i])
    }

  })

  describe('Base url is http://domain.com/, with /', () => {

    let expectMethod = (method: string) => {
  
      it(`appends base api url to the ${method} request`, inject([HttpService, MockBackend], (service: HttpService, backend: MockBackend) => {
        let domain = 'http://domain.com'
        service.base_url = domain + '/'
        let request_url = '/hello/world'

        backend.connections.subscribe((c) => {
          expect(c.request.url).toEqual(`${domain}${request_url}`)
          c.mockRespond(new Response(new ResponseOptions({ body: 'fake response' })))
        })

        if (method === 'post' || method === 'put' || method === 'patch')
          service[method](request_url, {}).subscribe()
        else
          service[method](request_url).subscribe()

      }));

    }

    let methods = ['post', 'get', 'put', 'patch', 'delete']

    for (let i = methods.length - 1; i >= 0; i--) {
      expectMethod(methods[i])
    }

  })

  describe('Base url dont begin with forward slash (/)', () => {

    let expectMethod = (method: string) => {
  
      it(`appends base api url to the ${method} request`, inject([HttpService, MockBackend], (service: HttpService, backend: MockBackend) => {
        let domain = 'http://domain.com'
        service.base_url = domain + '/'
        let request_url = 'hello/world'

        backend.connections.subscribe((c) => {
          expect(c.request.url).toEqual(`${domain}/${request_url}`)
          c.mockRespond(new Response(new ResponseOptions({ body: 'fake response' })))
        })

        if (method === 'post' || method === 'put' || method === 'patch')
          service[method](request_url, {}).subscribe()
        else
          service[method](request_url).subscribe()

      }));

    }

    let methods = ['post', 'get', 'put', 'patch', 'delete']

    for (let i = methods.length - 1; i >= 0; i--) {
      expectMethod(methods[i])
    }

  })

  // describe('Registration', () => {

  //   it('jsonizes error', inject([HttpService, MockBackend], (service: HttpService, backend: MockBackend) => {
      
  //     let errors = ['name cant be blank']

  //     let mockResponse = new Response(new ResponseOptions({
  //       status: 422,
  //       body: errors
  //     }))

  //     backend.connections.subscribe(c => c.mockError(mockResponse));

  //     let acct: IAccount = {
  //       name: '',
  //       email: '',
  //       password: '',
  //       password_confirmation: ''
  //     }

  //     service.registerAccount(acct).subscribe(
  //       (res) => {},
  //       (res) => {
  //         expect(res).toEqual(errors)
  //       })

  //   }));

  //   it('handles success response', inject([HttpService, MockBackend], (service: HttpService, backend: MockBackend) => {
      
  //     let acct: IAccount = {
  //       name: '',
  //       email: '',
  //       password: '',
  //       password_confirmation: ''
  //     }


  //     let mockResponse = new Response(new ResponseOptions({
  //       status: 422,
  //       body: acct
  //     }))

  //     backend.connections.subscribe(c => c.mockRespond(mockResponse));
  //     service.registerAccount(acct).subscribe(
  //       (res) => {
  //         expect(res).toBe(acct)
  //       })

  //   }));

  // });

});
