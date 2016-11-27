# Serializes the {Comment} model instance to json.
# Read more about active model serializers - https://github.com/rails-api/active_model_serializers

module Unsakini
  class CommentSerializer < ActiveModel::Serializer

    attributes :id, :content, :created_at, :updated_at

    belongs_to :user

  end

end
