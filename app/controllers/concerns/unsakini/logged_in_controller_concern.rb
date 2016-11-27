# Ensures users are logged in and sets `@user` instance variable in the controllers.
# This is included in the base api controller.
#
# Returns `401` error if user is not authenticated
module Unsakini
  module LoggedInControllerConcern
    extend ActiveSupport::Concern

    included do
      include Knock::Authenticable
      before_action :ensure_logged_in
    end

    private

    def ensure_logged_in
      authenticate_for Unsakini::User
      @user = current_unsakini_user
      head :unauthorized unless @user
    end

  end
end
