# Serializes the `Post` model instance to json.
# Read more about active model serializers - https://github.com/rails-api/active_model_serializers

class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :created_at, :updated_at

  belongs_to :user
  belongs_to :board
end
