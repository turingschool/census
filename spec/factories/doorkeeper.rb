FactoryBot.define do
  ActiveRecord::Base.inspect
  factory :access_token, class: Doorkeeper::AccessToken do
    resource_owner_id { create(:user).id }
    # application
    expires_in 2.hours

    factory :clientless_access_token do
      application nil
    end
  end

  factory :application, class: Doorkeeper::Application do
    sequence(:name) { |n| "Application #{n}" }
    redirect_uri 'https://localhost:3000/auth/census/callback'
  end
end
