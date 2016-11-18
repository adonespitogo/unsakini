# Ensures user is owner of the post and sets the `@post` variable in the controllers
module PostOwnerControllerConcern
  extend ActiveSupport::Concern
  # Ensures user is owner of the post and sets the `@post` variable in the controllers
  def ensure_post
    post_id = params[:post_id] || params[:id]
    @post = Post.where(id: post_id, board_id: params[:board_id])
                .joins("LEFT JOIN user_boards ON user_boards.board_id = posts.board_id")
                .where("user_boards.user_id = ?", @user.id)
                .first
    render status: :forbidden if @post.nil?
  end

end