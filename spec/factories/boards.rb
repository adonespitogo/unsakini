FactoryGirl.define do
  factory :board, class: "Unsakini::Board" do
    name {Faker::Name.title}
  end
end
