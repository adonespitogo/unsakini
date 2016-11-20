class Api::BoardsController < ApplicationController
  include BoardOwnerControllerConcern
  before_action :ensure_board, :only => [:show, :update, :destroy]
  before_action :ensure_board_owner, :only => [:update, :destroy]

  # Returns boards belonging to current user
  #
  # `GET /api/boards`
  #
  def index
    render json: @user.user_boards
  end

  # Creates board belonging to current user.
  #
  # `POST /api/boards`
  #
  def create
    @user_board = UserBoard.new(
      name: params[:board][:name],
      user_id: @user.id,
      encrypted_password: params[:encrypted_password],
      is_admin: true
    )
    if @user_board.save
      render json: @user_board, status: :created
    else
      render json: @user_board.errors.full_messages, status: 422
    end

  end

  # Render a single board.
  #
  # `GET /api/boards/:id`
  #
  def show
    render :json => @user_board
  end

  # Updates a single board.
  #
  # `PUT /api/boards/:id`
  def update
    if @user_board.update(name: params[:board][:name], encrypted_password: params[:encrypted_password])
      render json: @user_board
    else
      errors = @board.errors.full_messages.concat @user_board.errors.full_messages
      render json: errors, status: 422
    end
  end

  # Deletes a board resource.
  #
  # `DELETE /api/boards/:id`
  def destroy
    @board.destroy
    render status: :ok
  end

end
