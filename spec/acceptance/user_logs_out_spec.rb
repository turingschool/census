require 'rails_helper'

RSpec.feature 'User logs out' do
  scenario 'by selecting logout' do
    user = create(:user)
    login_user(user)
    click_link 'Logout'

    expect(page).to have_content('Log in')
    expect(page).to_not have_content("#{user.first_name} #{user.last_name}")
  end

  def login_user(user)
    visit root_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end
end
