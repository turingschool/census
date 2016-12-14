FactoryGirl.define do
  factory :invitation do
    status 0
    email "me@example.com"
    invitation_code nil
    user nil
    role
  end
end
