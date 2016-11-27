# Serializes the `User` model instance to json.
# Read more about active model serializers - https://github.com/rails-api/active_model_serializers
#
module Unsakini
  class UserSerializer < ActiveModel::Serializer
    attributes :id, :name, :email, :created_at, :updated_at
  end

end
