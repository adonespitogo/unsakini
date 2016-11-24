import { browser, element, by, ExpectedConditions } from 'protractor';

import { SignUpPage } from './signup.po';

describe('Registration Page', function() {
  let page: SignUpPage;

  beforeAll(() => {
    page = new SignUpPage();
    page.navigateTo();
  });

  it('shows vadiation errors', () => {
    page.fillForm({
      name: 'me',
      email: 'hello@world.com',
      password: '',
      password_confirmation: ''
    })

    page.submit();

    page.hasError('Password')

  });


});
