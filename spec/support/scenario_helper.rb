module BoardSpecHelper

  def create_board_scenario
    @user = create(:user)
  end

  def user_has_board_scenario
    @user = create(:user)
    @board = create(:board)
    @user_board = create(:user_board, {
                           user_id: @user.id,
                           board_id: @board.id,
                           is_admin: true,
    })
    @post = create(:post, {
                     user_id: @user.id,
                     board_id: @board.id
    })
    @comment = create(:comment, {
                        user_id: @user.id,
                        post_id: @post.id
    })
  end

  def user_has_shared_board_scenario
    user_has_board_scenario
    @user_2 = create(:user)

    @shared_board = create(:board)
    @shared_user_board_1 = create(:user_board, {
                                    user_id: @user.id,
                                    board_id: @shared_board.id,
                                    is_admin: true
    })
    @shared_user_board_2 = create(:user_board, {
                                    user_id: @user_2.id,
                                    board_id: @shared_board.id,
                                    is_admin: false
    })

    @shared_post = create(:post, {
                            user_id: @user.id,
                            board_id: @shared_board.id
    })
    @shared_comment = create(:comment, {
                               user_id: @user.id,
                               post_id: @shared_post.id
    })
  end

  def user_has_shared_board_with_posts_scenario
    user_has_shared_board_scenario

    @shared_post_2 = create(:post, {
                              user_id: @user_2.id,
                              board_id: @shared_board.id
    })

    @shared_comment_2 = create(:comment, {
                                 user_id: @user_2.id,
                                 post_id: @shared_post_2.id
    })

    @shared_comment_3 = create(:comment, {
                                 user_id: @user.id,
                                 post_id: @shared_post_2.id
    })
  end

  def user_is_sharing_a_board_scenario
    @user = create(:user)
    @user_2 = create(:user)
    @user_3 = create(:user)
    @user_4 = create(:user)
    @board = create(:board)

    @user_board = create(:user_board, {
                           is_admin: true,
                           user_id: @user.id,
                           board_id: @board.id
    })
    @post = create(:post, {
                     user_id: @user.id,
                     board_id: @board.id
    })
    @post_2 = create(:post, {
                       user_id: @user_2.id,
                       board_id: @board.id
    })
    @comment = create(:comment, {
                        user_id: @user.id,
                        post_id: @post.id,
    })
    @comment_2 = create(:comment, {
                          user_id: @user_2.id,
                          post_id: @post.id,
    })


    @payload = make_payload

    @payload_wo_comments = make_payload(comments: false)

    @payload_wo_posts = make_payload(:posts => false)
    @payload_wo_encrypted_password = make_payload(encrypted_password: false)
    @payload_wo_shared_user_ids = make_payload(shared_user_ids: false)
    @payload_w_invalid_post = make_payload[:posts] = [@post_2.attributes]
    @payload_w_invalid_comment = make_payload[:posts][0][:comments] = [@comment_2.attributes]

  end

  def make_payload(opts_hash = {})
    payload = {
      board: @board.attributes
    }
    post_hash = @post.attributes
    post_hash["title"] = Faker::Name.title
    post_hash["content"] = Faker::Hacker.say_something_smart

    comment_hash = @comment.attributes
    comment_hash["content"] = Faker::Hacker.say_something_smart

    payload[:posts] = [post_hash] if !(opts_hash[:posts] == false) || !(opts_hash[:comments] == false)
    payload[:posts][0][:comments] = [comment_hash] if !(opts_hash[:comments] == false)
    payload[:shared_user_ids] = [@user_2.id, @user_3.id, @user_4.id] if !(opts_hash[:shared_user_ids] == false)
    payload[:encrypted_password] = Faker::Crypto.md5 if !(opts_hash[:encrypted_password] == false)
    payload
  end

  def boards_pagination_scenario

    @user = create(:user)
    @num_boards = 50
    @num_my_shared_boards = 20

    @num_boards.times do
      board = create(:board)
      create(:user_board, {
               user_id: @user.id,
               board_id: board.id,
               is_admin: true,
               encrypted_password: Faker::Crypto.md5
      })
    end

    @num_my_shared_boards.times do

      shared_board = create(:board, {
                              is_shared: true
      })

      create(:user_board, {
               user_id: @user.id,
               board_id: shared_board.id,
               is_admin: true,
               encrypted_password: Faker::Crypto.md5
      })
    end

  end

  def user_has_many_posts
    user_has_board_scenario
    @num_posts = 35

    @num_posts.times do

      create(:post, {
               user_id: @user.id,
               board_id: @board.id
      })
    end

    @num_posts = @board.posts.count
  end

end


# include to spec env
RSpec.configure do |config|
  config.include BoardSpecHelper
end
