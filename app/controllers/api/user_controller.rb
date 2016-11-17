class Api::UserController < ApplicationController
  before_action :authenticate_user!
  before_action :assign_user

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

  private
    def assign_user
      @user = current_user
    end
end
