class Api::UsersController < ApplicationController

  # Renders the current user as json
  #
  # `GET /api/user/:id`
  #
  # Return format:
  # ```
  # {
  #   id: 1,
  #   name: 'Adones Pitogo',
  #   email: 'pitogo.adones@gmail.com',
  #   created_at: '..',
  #   updated_at: '..'
  # }
  # ```
  def show
    render json: @user
  end

# Returns the user with matching email
#
`GET /api/users/search`
  def search
    user = User.where(email: params[:email]).first
    if user
      render json: user
    else
      render status: :not_found
    end
  end

end
