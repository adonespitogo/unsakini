class Api::BoardsController < ApplicationController
  before_action :authenticate_user!
  before_action :assign_user

  def index
    render json: @user.boards
  end

  def create
    @board = Board.new(params.permit(:name))
    if @board.save
      @user_board = UserBoard.create({
        user_id: @user.id,
        board_id: @board.id,
        is_admin: true
      })
      render :json => @board
    else
      render :json => @board.errors, status: 422
    end
  end

  private
    def assign_user
      @user = current_user
    end
end
