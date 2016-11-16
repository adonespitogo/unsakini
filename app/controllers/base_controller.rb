class BaseController < ActionController::Base
  include ActionController::ImplicitRender
  include ActionView::Layouts

  def app
    render file: "#{Rails.root}/public/app/index.html", layout: false
  end
end