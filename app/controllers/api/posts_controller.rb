class Api::PostsController < ApplicationController

  include LoggedInControllerConcern
  include BoardOwnerControllerConcern
  include PostOwnerControllerConcern
  include ::ActionController::Serialization

  before_action :ensure_board, only: [:index, :create]
  before_action :ensure_post, only: [:show, :update, :destroy]
  before_action :ensure_post_owner, only: [:update, :destroy]

# Renders the post belonging to the board
#
# `GET /api/boards/:board_id/posts`
  def index
    render json: @board.posts
  end

# Renders a single post belonging to the board
#
# `GET /api/boards/:board_id/posts/:id`
  def show
    render json: @post
  end

# Creates a single post belonging to the board
#
# `POST /api/boards/:board_id/posts/`
  def create
    @post = Post.new(params.permit(:title, :content, :board_id))
    @post.user = @user
    if (@post.save)
      render json: @post, status: :created
    else
      render json: @post.errors, status: 422
    end
  end

# Updates a single post belonging to the board
#
# `PUT /api/boards/:board_id/posts/:id`
  def update
    if (@post.update(params.permit(:title, :content)))
      render json: @post, status: :ok
    else
      render json: @post.errors, status: 422
    end
  end

# Deletes a single post belonging to the board
#
# `DELETE /api/boards/:board_id/posts/:id`
  def destroy
    @post.destroy
    render status: :ok
  end

end
