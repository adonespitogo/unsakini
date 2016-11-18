

# module ShareBoardHelper

#   def payload
#     pl = {
#       board: @board.attributes,
#       posts: [
#         @post.attributes
#       ]
#     }

#     pl[:posts][0][:comments] = [@comment.attributes]
#     pl[:shared_user_ids] = [@user_2.id, @user_3.id]
#     pl[:encrypted_password] = 'secret'
#     pl
#   end

#   def payload_wo_comments
#     pl = payload
#     pl[:posts][0].tap { |hs| hs.delete(:comments) }
#     pl
#   end

#   def payload_wo_posts
#     pl = payload
#     pl.tap { |hs| hs.delete(:posts) }
#     pl
#   end

#   def payload_wo_encrypted_password
#     pl = payload
#     pl.tap { |hs| hs.delete(:encrypted_password) }
#     pl
#   end

#   def payload_wo_shared_user_ids
#     pl = payload
#     pl.tap { |hs| hs.delete(:shared_user_ids) }
#     pl
#   end

#   def payload_w_invalid_post
#     pl = payload
#     invalid_post = create(:post)
#     pl[:posts] = [create(:post).attributes]
#   end
# end


# RSpec.configure do |config|
#   config.include ShareBoardHelper
# end
