
module BoardOwnerConcern

  # Ensures user is owner of the board.
  def is_board_owner
    board_id = params[:board_id] || params[:id]
    @board = nil
    if !board_id.nil?
      @board = Board.find_by_id(board_id)
    else
      render status :bad_request, json: {errors: ["Param [:board_id] is nil"]}
      return
    end
    if (@board)
      @user_board = UserBoard.where(user_id: @user.id, board_id: board_id).first
      if (@user_board.nil?)
        render status: :unauthorized
      end
    else
      render status: :not_found
    end
  end

end