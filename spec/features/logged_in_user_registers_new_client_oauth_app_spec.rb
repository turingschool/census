require 'rails_helper'

RSpec.feature "Logged In User Registers New Client OAuth App", type: :feature do
  it "they get a client id and client secret" do
    visit new_oauth_application_path

    fill_in 'doorkeeper_application[name]', with: 'Thingy'
    fill_in 'doorkeeper_application[redirect_uri]', with: 'https://localhost:3000/auth/census/callback'
    click_on 'Submit'

    expect(page).to have_content('Application: Thingy')
    expect(page).to have_content('Application Id: ')
    expect(page).to have_content('Secret: ')
    expect(page).to have_content('Callback urls: https://localhost:3000/auth/census/callback')
  end
end
