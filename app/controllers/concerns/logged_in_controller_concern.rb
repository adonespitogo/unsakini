# Ensures users are logged in and sets `@user` instance variable in the controllers.
# This is included in the base api controller.
#
# Returns `401` error if user is not authenticated
module LoggedInControllerConcern
  extend ActiveSupport::Concern

  included do
    include Knock::Authenticable
  	before_action :authenticate_user
    before_action :set_user
  end


  private
  # Sets the `@user` variable in the controllers
  def set_user
  	render status: :unauthorized if current_user.nil?
    @user = current_user
  end

end
