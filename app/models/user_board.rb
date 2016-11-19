# UserBoard model, links the user and it's boards

class UserBoard < ApplicationRecord
  include EncryptableModelConcern
  validates :encrypted_password, presence: true

  encryptable_attributes :encrypted_password

  belongs_to :user
  belongs_to :board, autosave: true

  def set_name_and_password(name, password)
    ActiveRecord::Base.transaction do
      self.encrypted_password = password
      self.save!
      board.name = name
      board.save!
    end
  rescue ActiveRecord::RecordInvalid => exception
    return false
  end
end
