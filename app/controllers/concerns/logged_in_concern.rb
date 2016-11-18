# Ensures users are logged in
module LoggedInConcern
  extend ActiveSupport::Concern

  included do
    include DeviseTokenAuth::Concerns::SetUserByToken
    before_action :authenticate_user!
    before_action :assign_user
  end

  private
    def assign_user
      @user = current_user
    end

end