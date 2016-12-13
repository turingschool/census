FactoryGirl.define do
  factory :invitation do
    status "MyString"
    email "MyString"
    invitation_code "MyString"
    user nil
  end
end
