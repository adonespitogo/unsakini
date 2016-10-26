import { UnsakiniWebpackPage } from './app.po';

describe('unsakini-webpack App', function() {
  let page: UnsakiniWebpackPage;

  beforeEach(() => {
    page = new UnsakiniWebpackPage();
  });

  it('should display message saying app works', () => {
    page.navigateTo();
    expect(page.getParagraphText()).toEqual('app works!');
  });
});
