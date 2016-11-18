# UserBoard model, links the user and it's boards

class UserBoard < ApplicationRecord
  belongs_to :user
  belongs_to :board, autosave: true
end
