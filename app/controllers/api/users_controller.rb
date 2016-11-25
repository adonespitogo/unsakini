class Api::UsersController < ApplicationController

  include Knock::Authenticable
  before_action :authenticate_user
  before_action :set_user
  # include LoggedInControllerConcern
  include ::ActionController::Serialization

  skip_before_action :authenticate_user, only: [:create]
  skip_before_action :set_user, only: [:create]

  #Creates a new user
  def create
    @user = User.new(params.permit(:name, :email, :password, :password_confirmation))
    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors.full_messages, status: 422
    end
  end

  # Renders the current user as json
  #
  # `GET /api/user/:id`
  #
  def show
    render json: @user
  end

  # Returns the user with matching email
  #
  # `GET /api/users/search?email=xxx`
  #
  def search
    user = User.where("email = ? AND id != ?", params[:email], @user.id).first
    if user
      render json: user
    else
      render json: {}, status: :not_found
    end
  end

  private
  # Sets the `@user` variable in the controllers
  def set_user
    render json: {}, status: :unauthorized if current_user.nil?
    @user = current_user
  end

end
