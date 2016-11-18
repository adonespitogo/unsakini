# Ensures user is owner of the comment and sets the `@comment` variable in the controllers
module CommentOwnerControllerConcern
  extend ActiveSupport::Concern
  # Ensures user is owner of the comment and sets the `@comment` variable in the controllers
  def ensure_comment
    comment_id = params[:comment_id] || params[:id]
    @comment = Comment.where(id: comment_id, post_id: params[:post_id], user_id: @user.id).first
    render status: :unauthorized if @comment.nil?
  end

end