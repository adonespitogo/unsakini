class Api::UserController < ApiBaseController
  before_action :authenticate_user!
  before_action :assign_user
  def show
    render json: @user
  end

  private
    def assign_user
      @user = current_user
    end
end
