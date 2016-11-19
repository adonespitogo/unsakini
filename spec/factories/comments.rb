FactoryGirl.define do
  factory :comment do
    content {Faker::Hacker.say_something_smart}
    user_id 1
    post_id 1
  end
end
