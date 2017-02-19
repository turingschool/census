require 'rails_helper'

RSpec.feature 'User logs in' do
  scenario 'by providing email and password' do
    user = create(:enrolled_user)
    visit root_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    expect(page).to have_current_path(user_path(user))
    expect(page).to have_content(user.first_name)
    expect(page).to have_content(user.last_name)
  end
end
