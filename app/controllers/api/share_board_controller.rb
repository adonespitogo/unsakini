class Api::ShareBoardController < ApplicationController
  include BoardOwnerControllerConcern
  include PostOwnerControllerConcern
  include CommentOwnerControllerConcern

  before_action :validate_params

  # Shares a board to other users. Example payload param:
  #
  # `POST /api/share/board`
  #
  # ```
  # {
  #   board: {
  #     id: 1,
  #     name: 'some encrypted text',
  #     created_at: '..',
  #     updated_at: '..'
  #   },
  #   posts: [
  #     {
  #       board_id: 1,
  #       title: 'some encrypted text',
  #       content: 'some encrypted text',
  #       created_at: '..',
  #       updated_at: '..',
  #       comments: [
  #         {
  #           id: 1,
  #           content: 'some encrypted text',
  #           user_id: 1,
  #           post_id: 1,
  #           created_at: '..',
  #           updated_at: '..',
  #         }
  #       ]
  #     }
  #   ],
  #   shared_user_ids: [1, 2, 3, 4],
  #   encrypted_password: 'some encrypted password'
  # }
  # ```
  # The `encrypted_password` param will be used to decrypt contents of this board. The encryption happens in the client so
  # the server don't really know what is the original password. The board creator will have to share it privately to other users whom he/she
  # shares the board with.
  #
  # `posts` and `comments` can be empty.
  def index
    
  end

  # Validates the contents of params against the database records.
  def validate_params
    if params[:board]

      result = has_board_access(params[:board][:id])
      if result[:status] != :ok
        render status: result[:status]
        return
      else
        if !result[:user_board].is_admin
          render status: :forbidden
          return
        end
      end

      if params[:posts]

        params[:posts].each do |post|
          s = has_post_access(params[:board][:id], post[:id])
          if s != :ok
            render status: s
            return
          end

          if post[:comments]
            post[:comments].each do |comment|
              s = has_comment_access post[:id], comment[:id]
              if s != :ok
                render status: s
                return
              end
            end
          end

        end

      end

      if params[:encrypted_password].nil? or params[:shared_user_ids].nil?
        render status: 422
      end

    else
      render status: 422
    end
  end

  private
  def validate_posts(posts)

  end

end
