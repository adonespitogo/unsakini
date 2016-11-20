class Api::UsersController < ApplicationController

  # Renders the current user as json
  #
  # `GET /api/user/:id`
  #
  def show
    render json: @user
  end

# Returns the user with matching email
#
# `GET /api/users/search`
  def search
    user = User.where("email = ? AND email != ?", params[:email], @user.email).first
    if user
      render json: user
    else
      render status: :not_found
    end
  end

end
