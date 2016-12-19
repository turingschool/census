FactoryGirl.define do
  possible_cohorts = %w(1602 1603 1605 1606 1608 1610 1611 1701 1703)

  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    cohort { possible_cohorts.sample }
    password "password"
    confirmed_at DateTime.new()
  end
end
