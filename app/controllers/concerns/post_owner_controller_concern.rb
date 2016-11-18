module PostOwnerControllerConcern
  extend ActiveSupport::Concern
  # Ensures user is owner of the post.
  def ensure_post_set
    post_id = params[:id]
    @post = Post.where(id: post_id, board_id: params[:board_id], user_id: @user.id).first
    render status: :unauthorized if @post.nil?
  end

end