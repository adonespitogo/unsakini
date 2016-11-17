class Api::BoardsController < ApiBaseController
  before_action :authenticate_user!
  before_action :assign_user

  def index
    render json: []
  end

  private
    def assign_user
      @user = current_user
    end
end
