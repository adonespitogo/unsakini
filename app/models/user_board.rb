# UserBoard model, links the user and it's boards

class UserBoard < ApplicationRecord
  include EncryptableModelConcern
  validates :encrypted_password, presence: true

  encryptable_attributes :encrypted_password

  belongs_to :user
  belongs_to :board, autosave: true
end
