class Api::CommentsController < ApplicationController
  include PostOwnerControllerConcern
  include CommentOwnerControllerConcern


  before_action :ensure_post, only: [:index, :create]
  before_action :ensure_comment, only: [:show, :update, :destroy]

# Renders the comments belonging to the post
#
# `GET /api/boards/:board_id/posts/:post_id/`
  def index
    render json: @post.comments
  end

# Creates new comment belonging to the post
#
# `POST /api/boards/:board_id/posts/:post_id/`
  def create
    @comment = Comment.new(params.permit(:content))
    @comment.user = @user
    @comment.post = @post
    if @comment.save
      render json: @comment
    else
      render json: @comment.errors, status: 422
    end
  end


# Show single comment belonging to the post
#
# `GET /api/boards/:board_id/posts/:post_id/comments/:id`
  def show
  end

  def update
  end

  def destroy
  end
end
