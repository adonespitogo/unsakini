#Post model

class Post < BaseModel
  encryptable_attributes :title, :content
  validates :title, presence: true
  validates :content, presence: true

  belongs_to :user
  belongs_to :board
end
