FactoryGirl.define do
  factory :affiliation do
    user factory: :enrolled_user
    group
  end
end
