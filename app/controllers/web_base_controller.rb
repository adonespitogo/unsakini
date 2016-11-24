# Base controller for web pages

class WebBaseController < ActionController::Base
  include ActionController::ImplicitRender
  include ActionView::Layouts

  # Renders welcome page
  def index
  end

  # Renders the angular index view when request url is /app/* to enable html5 pushState capability of angularjs
  def app
    render file: "#{Rails.root}/public/app/index.html", layout: false
  end
end