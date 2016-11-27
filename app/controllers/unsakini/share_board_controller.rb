module Unsakini

  class ShareBoardController < BaseController

    include LoggedInControllerConcern
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
    #   },
    #   posts: [
    #     {
    #       board_id: 1,
    #       title: 'some encrypted text',
    #       content: 'some encrypted text',
    #       comments: [
    #         {
    #           id: 1,
    #           content: 'some encrypted text',
    #           user_id: 1,
    #           post_id: 1,
    #         }
    #       ]
    #     }
    #   ],
    #   shared_user_ids: [1, 2, 3, 4],
    #   encrypted_password: 'some encrypted password'
    # }
    # ```
    # The `encrypted_password` param will be used to decrypt contents of this board. The encryption happens in the client so
    # the server don't really know what is the original password. The board creator will have to share it privately to other users whom he/she shared it with so they can access the board.
    #
    # `posts` and `comments` fields can be empty.
    def index
      ActiveRecord::Base.transaction do
        if params[:posts]
          params[:posts].each do |post|
            p = Post.find(post[:id])
            p.title = post[:title]
            p.content = post[:content]
            p.save!

            if post[:comments] and p.valid?
              post[:comments].each do |comment|
                c = Comment.find(comment[:id])
                c.content = comment[:content]
                c.save!
              end
            end
          end
        end
        if @user_board.share(params[:shared_user_ids], params[:encrypted_password])
          render json: {}, status: :ok
        else
          raise "An error occured"
        end
      end
    rescue
      # clean up the created {UserBoard}s
      render json: ["Some of the data can't be saved."], status: 422
    end

    # Validates the contents of params against the database records.
    def validate_params

      if params[:encrypted_password].nil? or params[:shared_user_ids].nil? or params[:board].nil?
        render json: {}, status: 422
        return
      end

      result = has_board_access(params[:board][:id])
      if result[:status] != :ok
        render json: {}, status: result[:status]
        return
      else
        if !result[:user_board].is_admin
          render json: {}, status: :forbidden
          return
        end
        @board = result[:board]
        @user_board = result[:user_board]
      end

      if params[:posts]

        params[:posts].each do |post|
          s = has_post_access(params[:board][:id], post[:id])[:status]
          if s != :ok
            render json: {}, status: s
            return
          end

          if post[:comments]
            post[:comments].each do |comment|
              s = has_comment_access(post[:id], comment[:id])[:status]
              if s != :ok
                render json: {}, status: s
                return
              end
            end
          end

        end

      end

    end

  end

end
