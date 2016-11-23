require 'rails_helper'

RSpec.describe "WebBaseController", type: :request do

  describe 'catch html5 pushState routes' do

    def self.visit_app_urls(urls)
      urls.each do |url|
        it "renders app/index.html when visiting #{url}" do
          get "/#{url}"
          expect(response.body).to match File.read(Rails.public_path.join("app","index.html"))
        end
      end
    end

    visit_app_urls(['/app', 'app/', 'app/*anything'])

  end
end
