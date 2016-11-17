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

  # Render a single board.
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

  # Updates a single board.
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
  def update
    @user_board = UserBoard.where(user_id: @user.id, board_id: params[:id]).first
    if @user_board
      if @user_board.board.update(params.permit(:name))
        render :json => @user_board
      else
        render @user_board.board.errors, status: 422
      end
    else
      render status: :not_found
    end
  end

  # Deletes a board resource.

  # `DELETE /api/boards/:id`

  # Returns `200` status code on success
  #
  # Returns `401` status code if unauthorized
  #
  # Returns `404` status code if resource is not found

  def destroy
    @board = Board.find_by_id(params[:id])
    if (@board)
      @user_board = UserBoard.where(user_id: @user.id, board_id: params[:id]).first
      if (@user_board)
        @board.destroy
        render status: :ok
      else
        render status: :unauthorized
      end
    else
      render status: :not_found
    end
  end

  private
    def assign_user
      @user = current_user
    end
end
