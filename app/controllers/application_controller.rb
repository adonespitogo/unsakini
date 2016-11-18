class ApplicationController < ActionController::API
  include ::ActionController::Serialization
  include LoggedInConcern
  respond_to :json
end
