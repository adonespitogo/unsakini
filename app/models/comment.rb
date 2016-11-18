#Comment model
class Comment < ApplicationRecord
  include EncryptableModelConcern
  encryptable_attributes :content

  belongs_to :post
end
