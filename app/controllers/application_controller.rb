# Base controller for API controllers

class ApplicationController < ActionController::API
  include ::ActionController::Serialization
  include LoggedInControllerConcern
  respond_to :json
end
