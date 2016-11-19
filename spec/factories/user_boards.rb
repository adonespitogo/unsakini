FactoryGirl.define do
  factory :user_board do
    user_id 1
    board_id 1
    encrypted_password {Faker::Crypto.md5}
    is_admin false
  end
end
