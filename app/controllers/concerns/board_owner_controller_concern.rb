#Ensure user has access to the board and sets the `@board` variable in the controller
module BoardOwnerControllerConcern
  extend ActiveSupport::Concern

  #Ensure user has access to the board and sets the `@board` variable in the controller
  def ensure_board
    board_id = params[:board_id] || params[:id]
    @board = nil
    if !board_id.nil?
      @board = Board.find_by_id(board_id)
    else
      render status: :bad_request
      return
    end
    if (@board)
      @user_board = UserBoard.where(user_id: @user.id, board_id: board_id).first
      render status: :forbidden if @user_board.nil?
    else
      render status: :not_found
    end
  end

  #Ensures user is owner of the board.
  def ensure_board_owner
    render status: :forbidden if !@user_board.is_admin
  end

end