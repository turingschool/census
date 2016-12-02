require 'rails_helper'

RSpec.feature "Logged In User Registers New Client OAuth App", type: :feature do
  describe "they get a client id and client secret" do
    #s a Registered User
    user = User.create(first_name: 'Bryan', last_name: 'Goss', email: ENV['MY_EMAIL'])
    #n order to use OAuth with Census
    #hen I visit the Register App page
    visit new_oauth_app_path
    #nd I fill in App Name
    fill_in 'oauth_app[name]', with: 'Thingy'
    #nd I fill in App Callback URL
    fill_in 'oauth_app[callback_url]', with: 'http://localhost:3000/auth/census/callback'
    #nd I click Submit
    click_on 'Register Application'
    #hen I will see my Application's Page
    #nd I will see my Application's Name
    expect(page).to have_content('Application Name: Thingy')
    #nd I will see my Client ID
    expect(page).to have_content('Client ID: 2')
    #nd my Client Secret
    expect(page).to have_content('Client Secret: 1')
    #nd my Application's Callback URL.
    expect(page).to have_content('Callback URL: http://localhost:3000/auth/census/callback')
  end
end
