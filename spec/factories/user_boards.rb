FactoryGirl.define do
  factory :user_board, class: 'Unsakini::UserBoard' do
    name {Faker::Name.title}
    user_id 1
    board_id 1
    encrypted_password {Faker::Crypto.md5}
    is_admin false
  end
end
