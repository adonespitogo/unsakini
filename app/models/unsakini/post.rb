#Post model

module Unsakini
  class Post < ApplicationRecord
    include EncryptableModelConcern

    def self.table_name_prefix
      self.tbl_prefix
    end

    encryptable_attributes :title, :content
    validates :title, presence: true
    validates :content, presence: true

    belongs_to :user
    belongs_to :board
    has_many :comments, :dependent => :delete_all
  end
end
