FactoryGirl.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password "password"
    confirmed_at DateTime.new()

    factory :admin do
      after(:create) do | admin, _ |
        create_list(:role, 1, name: "admin", users: [admin])
      end
    end
  end
end
