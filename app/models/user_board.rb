# UserBoard model, links the user and it's boards

class UserBoard < ApplicationRecord
  include EncryptableModelConcern
  validates :encrypted_password, presence: true
  encryptable_attributes :encrypted_password

  belongs_to :user
  belongs_to :board, autosave: true

  def create_with_board(board_name, password)
    ActiveRecord::Base.transaction do
      b = Board.new(name: board_name)
      if b.save!
        self.is_admin = true
        self.board_id = b.id
        self.encrypted_password = password
        self.save!
      end
    end
  rescue
    false
  end

  # Updates the board name and encrypted_password within a transaction
  def update_password_and_board(board_name, password)
    ActiveRecord::Base.transaction do
      board.name = board_name
      board.save!
      self.encrypted_password = password
      self.save!
    end
  rescue ActiveRecord::RecordInvalid => invalid
    false
  end
end
