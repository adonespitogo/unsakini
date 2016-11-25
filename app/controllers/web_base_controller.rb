# Base controller for web pages

class WebBaseController < ActionController::Base
  include ActionController::ImplicitRender
  include ActionView::Layouts

  # Renders welcome page
  def index
  	@title = "Unsakini - Opensource Encrypted Bulletin Board"
  	@project = 'Unsakini'
  	@description = 'Opensource Encrypted Bulletin Board'
  	@long_description = "is an open source encrypted bulletin board created with the aim of evading global information surveillance and spying, preventing data leaks and promoting information confidentiality and integrity."
  	@version = Unsakini::VERSION
  	@author = 'Adones Pitogo'
  	@repository = 'https://github.com/adonespitogo/unsakini'
  	@tagline = "Created by and for online activists, information security enthusiasts and government surveillance evaders."
  end

  # Renders the angular index view when request url is /app/* to enable html5 pushState capability of angularjs
  def app
    render file: "#{Rails.root}/public/app/index.html", layout: false
  end
end