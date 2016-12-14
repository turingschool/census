FactoryGirl.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    image { "https://robohash.org/#{first_name}#{last_name}" }
    password "password"
    confirmed_at DateTime.new()
  end
end
