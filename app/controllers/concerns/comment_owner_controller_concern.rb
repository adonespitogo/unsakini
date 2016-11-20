# Ensures user is owner of the comment and sets the `@comment` variable in the controllers
module CommentOwnerControllerConcern
  extend ActiveSupport::Concern
  # Ensures user is owner of the comment and sets the `@comment` variable in the controllers
  def ensure_comment
    comment_id = params[:comment_id] || params[:id]
    post_id = params[:post_id]
    status = has_comment_access post_id, comment_id
    render status: status if status != :ok
  end

  # Validate comment access
  def has_comment_access(post_id, comment_id)
    @comment = Comment.where(id: comment_id, post_id: post_id, user_id: @user.id).first
    if @comment.nil?
      return :forbidden
    else
      return :ok
    end
  end

  # Ensures user is the owner of the comment. Must be run after {#ensure_comment} method.
  def ensure_comment_owner
    render status: :forbidden if @comment.user_id != @user.id
  end

end
