# Ensures user is owner of the post and sets the `@post` variable in the controllers
module PostOwnerControllerConcern
  extend ActiveSupport::Concern

  # Ensures user is owner of the post and sets the `@post` variable in the controllers
  def ensure_post
    post_id = params[:post_id] || params[:id]
    board_id = params[:board_id]
    status = has_post_access(board_id, post_id)
    render status: status if status != :ok
  end

  # Validate post access
  def has_post_access(board_id, post_id)
    @post = Post.where(id: post_id, board_id: board_id)
                .joins("LEFT JOIN user_boards ON user_boards.board_id = posts.board_id")
                .where("user_boards.user_id = ?", @user.id)
                .first
    if @post.nil?
      return :forbidden
    else
      return :ok
    end
  end

  # Ensures user is owner of the post. Must be run after {#ensure_post}`.
  def ensure_post_owner
    render status: :forbidden if @post.user_id != @user.id
  end

end