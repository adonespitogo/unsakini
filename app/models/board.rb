#Board model

class Board < ApplicationRecord
  include EncryptableModelConcern
  encryptable_attributes :name
  validates :name, presence: true

  has_many :users, through: :user_boards

  has_many :user_boards, :dependent => :delete_all
  has_many :posts, :dependent => :destroy

  # Share the board and it's contents to other users
  #
  # @param owner_id [Integer] id of the board owner
  # @param user_ids [Integer] array of user ids to share with
  # @param encrypted_password [String] new password for the board contents
  def share(owner_id, user_ids, encrypted_password)
    user_board = UserBoard.where("board_id = ? AND user_id = ?", self.id, owner_id).first
    if user_board.update_password_and_board(self.name, encrypted_password)
      ActiveRecord::Base.transaction do
        user_ids.each do |usr_id|
          UserBoard.new({
                          user_id: usr_id,
                          board_id: self.id,
                          encrypted_password: nil,
                          is_admin: false
          })
          .save!
          self.save!
        end
      end
      true
    else
      false
    end

  rescue
    false
  end



end
