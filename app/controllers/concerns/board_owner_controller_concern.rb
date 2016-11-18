#Ensure user has access to the board and sets the `@board` variable in the controller
module BoardOwnerControllerConcern
  extend ActiveSupport::Concern

  #Ensure user has access to the board and sets the `@board` variable in the controller
  def ensure_board
    board_id = params[:board_id] || params[:id]
    status = has_board_access(board_id)
    render status: status if status != :ok
  end

  # Validate board access
  def has_board_access(board_id)
    @board = nil
    if !board_id.nil?
      @board = Board.find_by_id(board_id)
    else
      return :bad_request
    end
    if (@board)
      @user_board = UserBoard.where(user_id: @user.id, board_id: board_id).first
      return :forbidden if @user_board.nil?
      return :ok
    else
      return :not_found
    end
  end

  #Ensures user is owner of the board. Must be run after `ensure_board` method.
  def ensure_board_owner
    render status: :forbidden if !@user_board.is_admin
  end

end
