/// <reference path="../../typings/index.d.ts" />

import { platformBrowserDynamic } from '@angular/platform-browser-dynamic';
import {enableProdMode} from '@angular/core';
import { AppModule } from './approot/approot.module';

//PRODUCTION_MODE_PLACEHOLDER

declare var $:any;

$(document).ready(function () {
  var token = $.jStorage.get('auth_token');
  $.get('/auth/verify?token=' + token)
    .done(function () {
      const platform = platformBrowserDynamic();
      platform.bootstrapModule(AppModule);
    })
    .fail(function (err) {
      window.location.assign('/login');
    });
});

