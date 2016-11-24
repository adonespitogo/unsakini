import { browser, element, by } from 'protractor';

export class AngularPage {
  navigateTo() {
    return browser.get('/app/');
  }

  getParagraphText() {
    return element(by.css('app-root h1')).getText();
  }
}
