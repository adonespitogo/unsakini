#Board model

class Board < ApplicationRecord
  include EncryptableModelConcern
  encryptable_attributes :name
  validates :name, presence: true

  has_many :users, through: :user_boards

  has_many :user_boards, :dependent => :delete_all
  has_many :posts, :dependent => :delete_all

end