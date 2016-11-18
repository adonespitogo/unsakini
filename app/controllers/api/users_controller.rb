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
  #   created_at: '..',
  #   updated_at: '..'
  # }
  # ```
  def show
    render json: @user
  end

end
