require 'json_web_token'

class Api::UsersController < ApiBaseController

  include LoggedInControllerConcern
  include ::ActionController::Serialization

  skip_before_action :authenticate_request!, only: [:create]

  #Creates a new user
  def create
    user = User.new(user_params)

    if user.save
      render json: user, status: :created
    else
      render json: user.errors.full_messages, status: 422
    end
  end

  # confirm user account
  def confirm
    token = params[:token].to_s

    user = User.find_by(confirmation_token: token)

    if user.present? && user.confirmation_token_valid?
      user.mark_as_confirmed!
      render json: {status: 'User confirmed successfully'}, status: :ok
    else
      render json: ['Invalid token'], status: :not_found
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

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end

  def login
    user = User.find_by(email: params[:email].to_s.downcase)

    if user && user.authenticate(params[:password])
      auth_token = JsonWebToken.encode({user_id: user.id})
      render json: {auth_token: auth_token}, status: :ok
    else
      render json: ['Invalid username / password'], status: :unauthorized
    end
  end

end
