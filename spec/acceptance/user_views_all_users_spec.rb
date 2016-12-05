require 'rails_helper'

RSpec.feature 'User views account info' do
  scenario 'by visiting user show page' do
    user = create(:user)
    visit root_path

    click_link 'Login'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    expect(page).to have_content("Users")


    expect(page).to have_content("First name")
    expect(page).to have_content("Last name")
    expect(page).to have_content("Slack")
    expect(page).to have_content("Cohort")
    expect(page).to have_content(user.first_name)
    expect(page).to have_content(user.last_name)
  end
end
