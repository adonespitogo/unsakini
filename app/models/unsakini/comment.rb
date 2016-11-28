#Comment model
module Unsakini
  class Comment < ApplicationRecord
    include EncryptableModelConcern

    def self.table_name_prefix
      self.tbl_prefix
    end

    encryptable_attributes :content
    validates :content, presence: true

    belongs_to :post
    belongs_to :user
  end
end
