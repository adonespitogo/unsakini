class UserBoard < BaseModel
  belongs_to :user
  belongs_to :board, autosave: true
end
