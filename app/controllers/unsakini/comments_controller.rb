class Unsakini::CommentsController < ApiBaseController

  include LoggedInControllerConcern
  include PostOwnerControllerConcern
  include CommentOwnerControllerConcern
  include ::ActionController::Serialization

  before_action :ensure_post, only: [:index, :create]
  before_action :ensure_comment, only: [:show, :update, :destroy]
  before_action :ensure_comment_owner, only: [:update, :destroy]

  # Renders the comments belonging to the post
  #
  # `GET /api/boards/:board_id/posts/:post_id/`
  def index
    paginate json: @post.comments.page(params[:page]), per_page: 20
  end

  # Creates new comment belonging to the post
  #
  # `POST /api/boards/:board_id/posts/:post_id/`
  def create
    @comment = Comment.new(params.permit(:content))
    @comment.user = @user
    @comment.post = @post
    if @comment.save
      render json: @comment
    else
      render json: @comment.errors, status: 422
    end
  end

  # Updates a comment
  #
  # `PUT /api/boards/:board_id/posts/:post_id/comments/:id`
  def update
    if @comment.update(params.permit(:content))
      render json: @comment
    else
      render json: @comment.errors, status: 422
    end
  end

  # Deletes a comment
  #
  # `DELETE /api/boards/:board_id/posts/:post_id/comments/:id`
  def destroy
    @comment.destroy
    render json: {}, status: :ok
  end
end
