import { browser, element, by, ExpectedConditions } from 'protractor';

import { SignUpPage } from './signup.po';

describe('Registration Page', function() {
  let page: SignUpPage;

  beforeEach(() => {
    page = new SignUpPage();
    page.navigateTo();
  });

  it('shows vadiation errors', () => {
    page.fillForm({
      name: 'me',
      email: 'hello@world.com',
      password: '123',
      password_confirmation: '1234'
    })

    page.submit();

    page.hasError('Password is too short')
    page.hasError('Password Confirmation doesn\'t match Password')

  });

  // it('shows required errors', () => {

  //   page.fillForm({
  //     name: 'me',
  //     email: 'hello@world.com',
  //     password: '123',
  //     password_confirmation: '1234'
  //   })

  //   page.clearForm()

  //   page.hasError('Name is required')
  //   page.hasError('Email is required')
  //   page.hasError('Password is required')
  //   page.hasError('Password Confirmation is required')

  // });


});
