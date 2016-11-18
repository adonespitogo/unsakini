class Api::CommentsController < ApplicationController
  include BoardOwnerControllerConcern
  include PostOwnerControllerConcern

  before_action :ensure_board
  before_action :ensure_post

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
