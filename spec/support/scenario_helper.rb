module BoardSpecHelper

  def user_has_board_scenario
    @user ||= create(:user)
    @board ||= create(:board)
    @user_board ||= create(:user_board, {
                             user_id: @user.id,
                             board_id: @board.id,
                             is_admin: true,
    })
    @post ||= create(:post, {
                       user_id: @user.id,
                       board_id: @board.id
    })
    @comment ||= create(:comment, {
                          user_id: @user.id,
                          post_id: @post.id
    })
  end

  def user_has_shared_board_scenario
    user_has_board_scenario
    @user_2 ||= create(:user)

    @shared_board ||= create(:board)
    @shared_user_board_1 ||= create(:user_board, {
                               user_id: @user.id,
                               board_id: @shared_board.id,
                               is_admin: true
    })
    @shared_user_board_2 ||= create(:user_board, {
                               user_id: @user_2.id,
                               board_id: @shared_board.id,
                               is_admin: false
    })

    @shared_post ||= create(:post, {
                              user_id: @user.id,
                              board_id: @shared_board.id
    })
    @shared_comment ||= create(:comment, {
                                 user_id: @user.id,
                                 post_id: @shared_post.id
    })
  end

  def create_board_scenario
    @user ||= create(:user)
  end

end

RSpec.configure do |config|
  config.include BoardSpecHelper
end
