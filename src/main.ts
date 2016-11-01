import './polyfills.ts';

import { platformBrowserDynamic } from '@angular/platform-browser-dynamic';
import { enableProdMode } from '@angular/core';
import { environment } from './environments/environment';
import { AppModule } from './app/';
import * as $ from 'jquery';

if (environment.production) {
  enableProdMode();
}


$(document).ready( () => {
  $("#footer").show();
  platformBrowserDynamic().bootstrapModule(AppModule);
});
