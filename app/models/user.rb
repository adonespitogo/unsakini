class User < ActiveRecord::Base

  # https://www.sitepoint.com/authenticate-your-rails-api-with-jwt-from-scratch/

  has_secure_password

  validates_presence_of :name
  validates_presence_of :email
  validates_uniqueness_of :email, case_sensitive: false
  validates_format_of :email, with: /@/
  validates :password, length: { minimum: 6 }

  validates :name, :email, presence: true
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
