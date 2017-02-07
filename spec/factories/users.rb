FactoryGirl.define do
  # possible_cohorts = %w(1602 1603 1605 1606 1608 1610 1611 1701 1703)

  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password "password"
    confirmed_at DateTime.new()
    cohort

    factory :admin do
      after(:create) do | admin, _ |
        create_list(:role, 1, name: "admin", users: [admin])
      end
    end

    factory :active_student do
      after(:create) do |active_student, _ |
        create_list(:role, 1, name: "active student", users: [active_student])
      end
    end

    factory :enrolled_user do
      after(:create) do |enrolled_user, _ |
        create_list(:role, 1, name: "enrolled", users: [enrolled_user])
      end
    end

    factory :user_with_roles do
      after(:create) do | user_with_roles, _ |
        create_list(:role, 2, name: "dummy_role", users: [user_with_roles])
      end
    end
  end
end
