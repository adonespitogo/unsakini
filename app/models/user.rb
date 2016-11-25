class User < ApplicationRecord

  has_secure_password

  validates :name, :email, presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validates :password, :presence => true,
    :confirmation => true,
    :length => {:within => 6..40},
    :on => :create

  has_many :user_boards
  has_many :boards, through: :user_boards

end
