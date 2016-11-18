class Api::PostsController < ApplicationController
  include BoardOwnerControllerConcern
  include PostOwnerControllerConcern

  before_action :ensure_board, only: [:index, :create]
  before_action :ensure_post, only: [:show]

# Renders the post belonging to the board
#
# `GET /api/boards/:board_id/posts`
  def index
    render json: @board.posts
  end

# Renders a single post belonging to the board
#
# `GET /api/boards/:board_id/posts/id`
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

end
