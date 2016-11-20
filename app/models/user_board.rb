# UserBoard model, links the user and it's boards

class UserBoard < ApplicationRecord
  include EncryptableModelConcern
  validates :encrypted_password, presence: true, if: :is_admin
  encryptable_attributes :encrypted_password

  belongs_to :user
  belongs_to :board, autosave: true

  # Creates {UserBoard} together with a new {Board}. This should be used when creating new board instead of the regular `save` method.
  #
  # @param board_name [String] name of the new board
  #
  def create_with_board(board_name)
    ActiveRecord::Base.transaction do
      b = Board.new(name: board_name)
      if b.save!
        self.is_admin = true
        self.board_id = b.id
        self.save!
      end
    end
  rescue
    false
  end

  # Updates its {Board}'s name and its `encrypted_password`. This should be used to update a board name or it's encrypted password.
  #
  # @param board_name [String] name of the new board
  # @param encrypted_password [String] a new encrypted key used to encrypt contents of this board.
  def update_password_and_board(board_name, encrypted_password)
    encrypted_password_changed = self.encrypted_password != encrypted_password
    ActiveRecord::Base.transaction do
      board.name = board_name
      board.save!
      self.encrypted_password = encrypted_password
      if self.save!
        reset_user_boards_encrypted_password if encrypted_password_changed
      end
    end
  rescue ActiveRecord::RecordInvalid => invalid
    false
  end

  # Resets other {UserBoard} belonging to its {Board}. This is used after the board's encrypted password has been updated (see {UserBoard.update_password_and_board} )
  def reset_user_boards_encrypted_password
    UserBoard.where("board_id = ? AND user_id != ?", self.board_id, self.user_id).update_all(encrypted_password: nil)
  end

end
