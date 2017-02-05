require 'rails_helper'

RSpec.feature 'User views account info' do
  scenario 'by visiting user show page' do
    user = create(:enrolled_user)
    login(user)

    expect(page).to have_content("Users")

    expect(page).to have_content("Name")
    expect(page).to have_content("Slack")
    expect(page).to have_content("Cohort")
    expect(page).to have_content(user.first_name)
    expect(page).to have_content(user.last_name)
  end
end
