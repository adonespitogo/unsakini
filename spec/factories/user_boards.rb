FactoryGirl.define do
  factory :user_board do
    user_id 1
    board_id 1
    encrypted_password "MyText"
    is_admin false
  end
end
