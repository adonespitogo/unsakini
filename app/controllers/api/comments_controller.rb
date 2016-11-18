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

  def show
  end

  def update
  end

  def destroy
  end
end
