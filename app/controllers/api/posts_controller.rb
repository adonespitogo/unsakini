class Api::PostsController < ApplicationController
  include BoardOwnerControllerConcern
  include PostOwnerControllerConcern

  before_action :ensure_board_set, only: [:index]
  before_action :is_post_owner, except: [:index]

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

end
