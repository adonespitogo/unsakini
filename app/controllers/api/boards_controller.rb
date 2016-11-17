class Api::BoardsController < ApplicationController
  before_action :authenticate_user!
  before_action :assign_user
  include ::ActionController::Serialization

  # Returns boards belonging to current user
  #
  # `GET /api/boards`
  #
  # Return format:
  # ```
  # [
  #  {
  #   is_admin: true,
  #   board: {
  #     id: 1,
  #     name: 'board name',
  #     created_at: ..,
  #     updated_at: ..,
  #   }
  #  }
  # ]
  # ```
  def index
    render json: @user.user_boards
  end

  # Creates board belonging to current user.
  #
  # `POST /api/boards`
  #
  # Param format
  # ```
  # {name: "sting"}
  # ```
  #
  # Return format:
  # ```
  #  {
  #   id: 1,
  #   name: 'board name',
  #   created_at: ..,
  #   updated_at: ..,
  #   board_user: {
  #    is_admin: true
  #   }
  #  }
  # ```
  def create
    @board = Board.new(params.permit(:name))
    if @board.save
      @user_board = UserBoard.create({
        user_id: @user.id,
        board_id: @board.id,
        is_admin: true
      })
      render :json => @user_board
    else
      render :json => @board.errors, status: 422
    end
  end

  private
    def assign_user
      @user = current_user
    end
end
