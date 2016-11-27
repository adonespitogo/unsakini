module Unsakini
  class UserTokenController < Knock::AuthTokenController
    def create
      if entity.confirmed_at?
        render json: auth_token, status: :created
      else
        res = {message: "Your account needs confirmation. Please follow the confirmation instructions sent to #{auth_params[:email]}"}
        render status: 401, json: res
      end
    end

    def entity_name
      self.class.name.split('TokenController').first
    end

  end
end
