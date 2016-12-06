require 'rails_helper'

RSpec.describe 'OAuth Access Grant' do
  it 'redirects to login for unauthenticated users' do
pending
    #As a not-signed-in registered user
    user = create :user
    #In order to grant access to an oauth client application
    application = create :oauth_application, name: 'Test App'
    #When I visit the authorize path
    visit "/oauth/authorize?client_id=#{application.uid}&response_type=code&redirect_uri=#{application.redirect_uri}"
    #Then I should see a log in page.
    expect(page).to have_content 'Log in'

    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_on 'Log in'
    expect(current_path).to eq(oauth_authorization_path)
    expect(page).to have_content 'Test App'
  end

  it 'displays grant information to authenticated users' do
    #As a registered user
    user = create :user
#    login(user)
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_on 'Log in'
    #In order to grant access to an oauth client application
    application = create :oauth_application, name: 'Test App'
    #When I visit the authorization path
    visit "/oauth/authorize?client_id=#{application.uid}&response_type=code&redirect_uri=#{application.redirect_uri}"
    #Then I should see the client app;ication's information
save_and_open_page
    expect(page).to have_content 'Test App'
    #And I should see an option to grant access
    #And I should see an option to deny access
  end
end
