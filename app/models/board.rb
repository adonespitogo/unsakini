class Board < BaseModel
  encryptable_attributes :name
  validates :name, presence: true

  has_many :user_boards
  has_many :users, through: :user_boards

end
