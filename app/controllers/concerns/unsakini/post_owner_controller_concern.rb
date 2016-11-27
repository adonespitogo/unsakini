# Ensures user is owner of the post and sets the `@post` variable in the controllers
module Unsakini
  module PostOwnerControllerConcern
    extend ActiveSupport::Concern

    # Ensures user is owner of the post and sets the `@post` variable in the controllers
    def ensure_post
      post_id = params[:post_id] || params[:id]
      board_id = params[:board_id]
      result = has_post_access(board_id, post_id)
      status = result[:status]
      @post = result[:post]
      head status if status != :ok
    end

    # Validate if user has access to the post in the board
    #
    # @param board_id [Integer] board id
    # @param post_id [Integer] post id
    def has_post_access(board_id, post_id)
      post = Unsakini::Post.where(id: post_id, board_id: board_id)
      .joins("LEFT JOIN user_boards ON user_boards.board_id = posts.board_id")
      .where("user_boards.user_id = ?", @user.id)
      .first
      if post.nil?
        return {status: :forbidden}
      else
        return {status: :ok, post: post}
      end
    end

    # Ensures user is owner of the post. Must be run after {#ensure_post}`.
    def ensure_post_owner
      render json: {}, status: :forbidden if @post.user_id != @user.id
    end

  end
end
