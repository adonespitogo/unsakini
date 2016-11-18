class Api::BoardsController < ApplicationController
  include BoardOwnerControllerConcern
  before_action :ensure_board, :only => [:show, :update, :destroy]

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
    render :json => @user_board
  end

  # Updates a single board.
  #
  # `PUT /api/boards/:id`
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
    if @user_board.is_admin
      if @user_board.board.update(params.permit(:name))
        render :json => @user_board
      else
        render @user_board.board.errors, status: 422
      end
    else
      render status: :forbidden
    end
  end

  # Deletes a board resource.

  # `DELETE /api/boards/:id`

  # Returns `200` status code on success
  #
  # Returns `401` status code if forbidden
  #
  # Returns `404` status code if resource is not found

  def destroy
    if @user_board.is_admin
      @board.destroy
      render status: :ok
    else
      render status: :forbidden
    end
  end

end
