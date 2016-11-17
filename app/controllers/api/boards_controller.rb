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
  # Success return format:
  # ```
  # {
  #   is_admin: true,
  #   board: {
  #     id: 1,
  #     name: 'board name',
  #     created_at: '..',
  #     updated_at: '..'
  #   }
  # }
  # ```
  def create
    @board = Board.new(params.permit(:name))
    if @board.save
      @user_board = UserBoard.create({
        user_id: @user.id,
        board_id: @board.id,
        is_admin: true
      })
      render :json => @user_board, status: :created
    else
      render :json => @board.errors, status: 422
    end
  end

  # Creates board belonging to current user.
  #
  # `GET /api/boards/:id`
  #
  # Return format:
  # ```
  # {
  #   is_admin: true,
  #   board: {
  #     id: 1,
  #     name: 'board name',
  #     created_at: '..',
  #     updated_at: '..'
  #   }
  # }
  # ```
  def show
    @user_board = UserBoard.where(user_id: @user.id, board_id: params[:id]).first
    if @user_board
      render :json => @user_board
    else
      render status: :not_found
    end
  end

  private
    def assign_user
      @user = current_user
    end
end
