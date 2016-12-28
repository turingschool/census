require 'rails_helper'

RSpec.feature "Logged In User Registers New Client OAuth App", type: :feature do
  it "they get a client id and client secret" do
    user = create :user
    login(user)

    visit new_oauth_application_path

    fill_in 'doorkeeper_application[name]', with: 'Monocle'
    fill_in 'doorkeeper_application[redirect_uri]', with: 'https://localhost:3000/auth/census/callback'
    click_on 'Submit'

    expect(page).to have_content('Application: Monocle')
    expect(page).to have_content('Application Id: ')
    expect(page).to have_content('Secret: ')
    expect(page).to have_content('Callback urls: https://localhost:3000/auth/census/callback')
  end

  it 'sees a useful error if information is missing' do
    me = create :user
    sign_in me

    visit new_oauth_application_path

    fill_in 'doorkeeper_application[name]', with: 'Monocle'

    click_on 'Submit'

    expect(page).to have_content "Redirect URI Can't be blank"
  end
end
