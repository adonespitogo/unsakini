# Serializes the `UserBoard` model instance to json.
# Read more about active model serializers - https://github.com/rails-api/active_model_serializers
#

class UserBoardSerializer < ActiveModel::Serializer
  attributes :id, :is_admin, :encrypted_password, :created_at, :updated_at
  belongs_to :board


end
