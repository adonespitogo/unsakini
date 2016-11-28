# UserBoard model, links the user and it's boards
module Unsakini
  class UserBoard < ApplicationRecord
    include EncryptableModelConcern

    encryptable_attributes :encrypted_password

    validates :encrypted_password, :presence => true, if: :is_admin

    before_validation :validate_before_create, on: :create
    before_validation :validate_before_update, on: :update

    belongs_to :user
    belongs_to :board

    scope :admin, -> { where(is_admin: true) }

    def name=(str)
      @name = str
    end

    def name
      if !@name.nil?
        @name
      else
        self.board.name
      end
    end

    # Returns user_boards where {Board} is `is_shared`
    #
    # @param is_shared [Boolean] wether to return shared or not shared boards
    def self.shared(is_shared)
      joins("LEFT JOIN #{Board.table_name} ON #{self.table_name}.board_id = #{Board.table_name}.id")
      .where("#{Board.table_name}.is_shared = ?", is_shared)
    end

    def share(user_ids, new_key)
      ActiveRecord::Base.transaction do
        user_ids.each do |usr_id|
          UserBoard.new({
                          user_id: usr_id,
                          board_id: self.board_id,
                          encrypted_password: nil,
                          is_admin: false
          })
          .save!
        end
        self.board.is_shared = true
        self.encrypted_password = new_key
        self.save!
      end
      true

    rescue
      self.errors[:base] << "Unable to share the this board"
      false
    end

    private

    def reset_user_boards_encrypted_password
      UserBoard.where("board_id = ? AND user_id != ?", self.board_id, self.user_id).update_all(encrypted_password: nil)
    end

    def validate_before_create
      if self.board.nil?
        b = Board.new(name: @name)
        if b.save
          self.board_id = b.id
        else
          self.errors[:base] << "Board name is invalid"
        end
      end
    end

    def validate_before_update
      self.board.name = @name if !@name.blank?
      reset_user_boards_encrypted_password if self.encrypted_password_changed?
      self.errors[:base] << "Board name is invalid" if !self.board.save
    end

  end
end
