FactoryGirl.define do
  factory :board do
    name {Faker::Name.title}
  end
end
