#Post model

module Unsakini
  class Post < ApplicationRecord
    include EncryptableModelConcern

    encryptable_attributes :title, :content
    validates :title, presence: true
    validates :content, presence: true

    belongs_to :user
    belongs_to :board
    has_many :comments, :dependent => :delete_all
  end
end
