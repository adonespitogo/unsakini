# Serializes the `Post` model instance to json.
# Read more about active model serializers - https://github.com/rails-api/active_model_serializers

class PostSerializer < ActiveModel::Serializer

  attributes :id, :title, :content, :created_at, :updated_at

  belongs_to :user

  belongs_to :board do |serializer|
    user_board = object.board.user_boards.where(user_id: object.user_id).first

    {
      "id" => object.board.id,
      "name" => object.board.name,
      "is_admin" => user_board.is_admin,
      "encrypted_password" => user_board.encrypted_password,
      "created_at" => object.board.created_at,
      "updated_at" => object.board.updated_at
    }
  end

end
