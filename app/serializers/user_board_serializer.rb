# Serializes the `UserBoard` model instance to json.
# Read more about active model serializers - https://github.com/rails-api/active_model_serializers
#

class UserBoardSerializer < ActiveModel::Serializer
  attributes :is_admin, :encrypted_password
  belongs_to :board
end
