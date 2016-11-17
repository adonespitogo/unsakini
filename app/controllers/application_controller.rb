class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  respond_to :json
  include ActionController::Serialization
  # include ActionController::ImplicitRender
  # include ActionView::Layouts
end
