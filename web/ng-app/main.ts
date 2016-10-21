/// <reference path="../../typings/index.d.ts" />

import { platformBrowserDynamic } from '@angular/platform-browser-dynamic';

import { AppModule } from './app.module';

console.log('hello world!');

const platform = platformBrowserDynamic();
platform.bootstrapModule(AppModule);

