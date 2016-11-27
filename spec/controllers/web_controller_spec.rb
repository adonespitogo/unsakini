require 'rails_helper'

RSpec.describe "WebBaseController", type: :request do

  it "renders the welcome page" do
    get "/"
    expect(response).to have_http_status :ok
    expect(response.body).to include('Unsakini')
  end

  describe 'catch html5 pushState routes' do

    def self.visit_app_urls(urls)
      urls.each do |url|
        it "renders web app index.html when visiting #{url}" do
          get "/#{url}"
          gem_root = File.expand_path '../../..', __FILE__
          expect(response.body).to match File.read("#{gem_root}/public/unsakini/app/index.html")
        end
      end
    end

    visit_app_urls(['/unsakini/app', 'unsakini/app/', 'unsakini/app/*anything'])

  end

end
