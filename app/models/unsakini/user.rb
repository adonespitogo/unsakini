module Unsakini
  class User < ActiveRecord::Base

    has_secure_password

    validates_uniqueness_of :email, case_sensitive: false, on: [:create]
    validates_format_of :email, with: /@/
    validates :name, :email, presence: true
    validates :password, :presence     => true,
      :confirmation => true,
      :length       => { :minimum => 6 },
      :if           => :password # only validate if password changed!

    has_many :user_boards
    has_many :boards, through: :user_boards

    before_save :downcase_email
    before_create :generate_confirmation_instructions

    def downcase_email
      self.email = self.email.delete(' ').downcase
    end

    def generate_confirmation_instructions
      self.confirmation_token = SecureRandom.hex(10)
      self.confirmation_sent_at = Time.now.utc
    end

    def confirmation_token_valid?
      (self.confirmation_sent_at + 30.days) > Time.now.utc
    end

    def mark_as_confirmed!
      self.confirmation_token = nil
      self.confirmed_at = Time.now.utc
      save
    end

  end

end
