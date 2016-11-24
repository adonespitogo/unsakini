# Ensures user is owner of the comment and sets the `@comment` variable in the controllers
module CommentOwnerControllerConcern
  extend ActiveSupport::Concern
  
  # Ensures user is owner of the comment and sets the `@comment` variable in the controllers
  def ensure_comment
    post_id = params[:post_id]
    comment_id = params[:comment_id] || params[:id]
    result = has_comment_access post_id, comment_id
    @comment = result[:comment]
    status = result[:status]
    render json: {}, status: status if status != :ok
  end

  # Validate if user has access to comment in the post
  #
  # @param post_id [Integer] post id
  # @param comment_id [Integer] comment id
  def has_comment_access(post_id, comment_id)
    comment = Comment.where(id: comment_id, post_id: post_id, user_id: @user.id).first
    if comment.nil?
      return {status: :forbidden, comment: comment}
    else
      return {status: :ok, comment: comment}
    end
  end

  # Ensures user is the owner of the comment. Must be run after {#ensure_comment} method.
  def ensure_comment_owner
    render json: {}, status: :forbidden if @comment.user_id != @user.id
  end

end
