# Ensures users are logged in and sets `@user` instance variable in the controllers.
# This is included in the base api controller.
#
# Returns `401` error if user is not authenticated
module LoggedInControllerConcern
  extend ActiveSupport::Concern

  included do
    include DeviseTokenAuth::Concerns::SetUserByToken
    before_action :authenticate_api_user!
    before_action :set_user
  end

  private

  # Sets the `@user` variable in the controllers
  def set_user
    render json: {}, status: :unauthorized if current_api_user.nil?
    @user = current_api_user
  end

end
