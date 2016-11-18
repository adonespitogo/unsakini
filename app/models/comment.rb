#Comment model
class Comment < ApplicationRecord
  include EncryptableModelConcern
  encryptable_attributes :content
  validates :content, presence: true

  belongs_to :post
  belongs_to :user
end
