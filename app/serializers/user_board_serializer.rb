class UserBoardSerializer < ActiveModel::Serializer
  attributes :is_admin

  belongs_to :board
end
