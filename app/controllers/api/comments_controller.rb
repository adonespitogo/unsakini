class Api::CommentsController < ApplicationController
  include BoardOwnerControllerConcern
  include PostOwnerControllerConcern

  before_action :ensure_board
  before_action :ensure_post

# Renders the comments belonging to the post
#
# `GET /api/boards/:board_id/posts/:post_id/`
  def index
    render json: @post.comments
  end

  def create
  end

  def show
  end

  def update
  end

  def destroy
  end
end
