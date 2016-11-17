class Board < BaseModel
  encryptable_attributes :name
  validates :name, presence: true

  has_many :user_boards
  has_many :users, through: :user_boards
  accepts_nested_attributes_for :user_boards, allow_destroy: true

end
