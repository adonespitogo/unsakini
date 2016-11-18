class Board < BaseModel
  encryptable_attributes :name
  validates :name, presence: true

  has_many :user_boards, :dependent => :delete_all
  has_many :users, through: :user_boards
  has_many :posts

end
