/// <reference path="../../typings/index.d.ts" />

//PRODUCTION_MODE_PLACEHOLDER
import { platformBrowserDynamic } from '@angular/platform-browser-dynamic';
import { AppModule } from './approot/approot.module';


const platform = platformBrowserDynamic();
declare var $:any;

$(document).ready(function () {
  var token = $.jStorage.get('auth_token');
  $.get('/auth/verify?token=' + token)
    .done(function () {
      platform.bootstrapModule(AppModule);
    })
    .fail(function (err) {
      window.location.assign('/login');
    });
});

