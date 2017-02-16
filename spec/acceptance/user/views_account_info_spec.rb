require 'rails_helper'

RSpec.feature 'User views account info' do
  scenario 'by visiting user show page' do
    user = create(:enrolled_user)
    login(user)

    click_link 'My Account'

    expect(page).to have_content("My Account")
    expect(page).to have_content(user.first_name)
    expect(page).to have_content(user.last_name)
    expect(page).to have_content(user.email)
    expect(page).to have_link("Edit profile")
  end
end
