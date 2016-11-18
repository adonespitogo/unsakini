class Api::BoardsController < ApplicationController
  include BoardOwnerControllerConcern
  before_action :ensure_board, :only => [:show, :update, :destroy]
  before_action :ensure_board_owner, :only => [:update, :destroy]

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
    @board = Board.new(params.require(:board).permit(:name))
    if @board.save
      @user_board = UserBoard.new({
                                    user_id: @user.id,
                                    board_id: @board.id,
                                    encrypted_password: params[:encrypted_password],
                                    is_admin: true
      })
      if @user_board.save
        render :json => @user_board, status: :created
      else
        render json: @user_board.errors, status: 422
      end
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
    if @user_board.board.update(name: params[:board][:name])
      if @user_board.update(params.permit(:encrypted_password))
        render :json => @user_board
      else
        render :json => @user_board.board.errors, status: 422
      end
    else
      render @user_board.board.errors
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
    @board.destroy
    render status: :ok
  end

end
