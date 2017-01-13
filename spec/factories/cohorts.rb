FactoryGirl.define do
  factory :cohort do
    name { Faker::Number.number(4) }
  end
end
