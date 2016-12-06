FactoryGirl.define do
  factory :oauth_application, class: Doorkeeper::Application do
    name 'Client Application'
    uid 'Client ID'
    secret 'Client Secret'
    redirect_uri 'https://localhost:3000/auth/census/callback'
    scopes ""
  end
end
