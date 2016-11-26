# Base controller for web pages

class WebBaseController < ActionController::Base
  include ActionController::ImplicitRender
  include ActionView::Layouts

  # Renders welcome page
  def index
  	@project = 'Unsakini'
  	@description = 'Privacy. Confidentiality. Security.'
  	@version = Unsakini::VERSION
  	@author = 'Adones Pitogo'
  	@repository = 'https://github.com/adonespitogo/unsakini'
  	@title = "#{@project} | #{@description}"
  	@tagline = "Created by and for online activists, information security enthusiasts and government surveillance evaders."
  	@keywords = "unsakini, encrypted, bulletin board, BB, ruby, rails"
  end

  # Renders the angular index view when request url is /app/* to enable html5 pushState capability of angularjs
  def app
    gem_root = File.expand_path '../../..', __FILE__

    render file: "#{gem_root}/public/app/index.html", layout: false
  end
end