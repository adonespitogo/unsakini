class Post < BaseModel
  encryptable_attributes :title, :content
  belongs_to :user
  belongs_to :board
end
