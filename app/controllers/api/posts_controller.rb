class Api::PostsController < ApplicationController
  include BoardOwnerConcern
  before_action :is_board_owner
  def index
    render json: @board.posts
  end

end
