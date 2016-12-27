require 'rails_helper'

RSpec.feature 'User logs in' do
  scenario 'by providing email and password' do
    user = create(:user)
    visit root_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    expect(page).to have_content('Users')
    expect(page).to have_content("#{user.first_name} #{user.last_name}")
  end
end
