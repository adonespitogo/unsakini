FactoryGirl.define do
  factory :post, class: 'Unsakini::Post' do
    title {Faker::Name.title}
    content {Faker::Hacker.say_something_smart}
    user_id 1
    board_id 1
  end
end
