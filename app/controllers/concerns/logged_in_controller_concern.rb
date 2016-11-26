# Ensures users are logged in and sets `@user` instance variable in the controllers.
# This is included in the base api controller.
#
# Returns `401` error if user is not authenticated
module LoggedInControllerConcern
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_request!
  end

  private


  # Sets the @user with the user_id from payload
  def load_current_user!
    @user = User.find_by(id: payload[0]['user_id'])
  end

  protected
  # Validates the token and user and sets the @current_user scope
  def authenticate_request!
    if !payload || !JsonWebToken.valid_payload(payload.first)
      return invalid_authentication
    end

    load_current_user!
    invalid_authentication unless @user
  end

  # Returns 401 response. To handle malformed / invalid requests.
  def invalid_authentication
    render json: {error: 'Invalid Request'}, status: :unauthorized
  end

  # Deconstructs the Authorization header and decodes the JWT token.
  def payload
    auth_header = request.headers['Authorization']
    token = auth_header.split(' ').last
    JsonWebToken.decode(token)
  rescue
    nil
  end

end
