require 'rails_helper'

RSpec.describe 'OAuth Access Grant' do
  it 'redirects to login for unauthenticated users' do
    user = create :user
    application = create :application, name: 'Test App', owner: user

    visit "/oauth/authorize?client_id=#{application.uid}&response_type=code&redirect_uri=#{application.redirect_uri}"

    expect(page).to have_content 'Log In'
  end

  it 'displays grant information to authenticated users' do
    user = create :user
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_on 'Log in'

    application = create :application, name: 'Test App', owner: user
    visit "/oauth/authorize?client_id=#{application.uid}&response_type=code&redirect_uri=#{application.redirect_uri}"

    expect(page).to have_content 'Test App'
    expect(page).to have_button 'Authorize'
    expect(page).to have_button 'Deny'
  end
end
